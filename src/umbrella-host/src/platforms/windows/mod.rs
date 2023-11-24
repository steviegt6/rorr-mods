mod evil;
mod suspended;

use windows::Win32::Foundation::{BOOL, FALSE, HANDLE, HMODULE, TRUE};
use windows::Win32::System::Console::{
    AllocConsole, GetConsoleMode, GetStdHandle, SetConsoleMode, SetConsoleTitleA, CONSOLE_MODE,
    ENABLE_EXTENDED_FLAGS, ENABLE_QUICK_EDIT_MODE, STD_INPUT_HANDLE,
};
use windows::{core::PCSTR, Win32::UI::WindowsAndMessaging::MessageBoxA};

use self::suspended::SuspendAllThreadsResult;

struct WindowsData {
    instance: HMODULE,
    suspension_result: SuspendAllThreadsResult,
}

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

unsafe extern "system" fn thread_main(data: &WindowsData) -> u32 {
    suspended::suspend_this_thread(data.suspension_result.main_thread);
    crate::early_main();
    crate::shared_main();
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

    let result = suspended::suspend_all_threads();
    let data = WindowsData {
        instance: hinst_dll,
        suspension_result: result,
    };

    std::thread::spawn(move || {
        thread_main(&data);
    });
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
