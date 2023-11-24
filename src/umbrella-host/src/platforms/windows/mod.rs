mod evil;
mod suspended;

use windows::Win32::Foundation::{CloseHandle, BOOL, FALSE, HANDLE, HMODULE, TRUE};
use windows::Win32::System::Console::{
    AllocConsole, GetConsoleMode, GetStdHandle, SetConsoleMode, SetConsoleTitleA, CONSOLE_MODE,
    ENABLE_EXTENDED_FLAGS, ENABLE_QUICK_EDIT_MODE, STD_INPUT_HANDLE,
};
use windows::Win32::System::Threading::CreateThread;
use windows::{core::PCSTR, Win32::UI::WindowsAndMessaging::MessageBoxA};

pub fn display_message_box(title: &str, message: &str) {
    unsafe {
        MessageBoxA(
            None,
            PCSTR(format!("{}\0", message).as_ptr()),
            PCSTR(format!("{}\0", title).as_ptr()),
            windows::Win32::UI::WindowsAndMessaging::MESSAGEBOX_STYLE(0),
        );
    }
}

pub fn initialize_console() {
    unsafe {
        _ = AllocConsole();

        evil::initialize_console();

        let input = GetStdHandle(STD_INPUT_HANDLE).expect("Failed to get input handle");
        let mut mode: CONSOLE_MODE = std::mem::zeroed();
        _ = GetConsoleMode(input, &mut mode);
        _ = SetConsoleMode(
            input,
            ENABLE_EXTENDED_FLAGS | (mode & !ENABLE_QUICK_EDIT_MODE),
        );
    };
}

pub fn set_console_title(title: &str) {
    unsafe {
        _ = SetConsoleTitleA(PCSTR(format!("{}\0", title).as_ptr()));
    }
}

pub fn is_suspended_process() -> bool {
    unsafe {
        let mut suspended = false;
        let success = suspended::is_process_suspended(&mut suspended);
        display_message_box(
            "suspended?",
            &format!("suspended: {} success: {}", suspended, success),
        );
        return !success || suspended;
    }
}

pub fn restart_process_as_suspended(p: *mut ::core::ffi::c_void) {
    unsafe {
        let success =
            suspended::restart_process(suspended::get_current_dll_path(HMODULE(p as isize)));
        if !success {
            display_message_box(
                "Error",
                "Failed to restart process as suspended. Please report this.",
            );
        }
    }
}

unsafe extern "system" fn thread_main(p: *mut ::core::ffi::c_void) -> u32 {
    crate::shared_main(p);
    return 0;
}

// Windows DLL entrypoint.
#[no_mangle]
pub unsafe extern "system" fn DllMain(
    hinst_dll: HMODULE,
    fdw_reason: u32,
    _lpv_reserved: *mut std::ffi::c_void,
) -> BOOL {
    if fdw_reason != 1 {
        return TRUE;
    }

    CloseHandle(
        CreateThread(
            None,
            0,
            Some(thread_main),
            Some(std::mem::transmute(hinst_dll)),
            windows::Win32::System::Threading::THREAD_CREATION_FLAGS(0),
            None,
        )
        .expect("Failed to start thread"),
    )
    .expect("Failed to close thread handle");
    return TRUE;
}

// Proxy target: dbgcore.dll
#[no_mangle]
pub extern "C" fn MiniDumpReadDumpStream(
    _: *mut std::ffi::c_void,
    _: u64,
    _: *mut std::ffi::c_void,
    _: *mut std::ffi::c_void,
    _: *mut std::ffi::c_void,
) -> BOOL {
    return FALSE;
}

#[no_mangle]
pub extern "C" fn MiniDumpWriteDump(
    _: HANDLE,
    _: u32,
    _: HANDLE,
    _: u32,
    _: *mut std::ffi::c_void,
    _: *mut std::ffi::c_void,
    _: *mut std::ffi::c_void,
) -> BOOL {
    return FALSE;
}
