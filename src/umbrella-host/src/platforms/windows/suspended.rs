use windows::Win32::Foundation::{HANDLE, HMODULE, NTSTATUS};

extern "C" {
    pub fn is_process_suspended(suspended: *mut bool) -> bool;
    pub fn resume_process(process_handle: HANDLE) -> NTSTATUS;
    pub fn restart_process(dll_to_inject: *const u8) -> bool;
    pub fn get_current_dll_path(instance: HMODULE) -> *const u8;
}
