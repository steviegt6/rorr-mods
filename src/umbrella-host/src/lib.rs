use windows::Win32::Foundation::{BOOL, FALSE, HANDLE, HMODULE, TRUE};
mod platforms;

// Windows DLL entrypoint.
#[cfg(target_os = "windows")]
#[no_mangle]
pub extern "system" fn DllMain(
    _hinst_dll: HMODULE,
    fdw_reason: u32,
    _lpv_reserved: *mut std::ffi::c_void,
) -> BOOL {
    if fdw_reason == 1 {
        platforms::display_message_box("Hello from Rust", "Hello from Rust");
    }

    return TRUE;
}

// Proxy target: dbgcore.dll
#[cfg(target_os = "windows")]
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

#[cfg(target_os = "windows")]
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
