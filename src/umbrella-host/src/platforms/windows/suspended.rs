use windows::Win32::Foundation::{HANDLE, NTSTATUS};

extern "C" {
    pub fn is_process_suspended(suspended: *mut bool) -> bool;
    pub fn resume_process(process_handle: HANDLE) -> NTSTATUS;
}
