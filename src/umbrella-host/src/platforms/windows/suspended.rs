#[repr(C)]
pub struct SuspendAllThreadsResult {
    pub success: bool,
    pub main_thread: u32,
}

extern "C" {
    pub fn suspend_all_threads() -> SuspendAllThreadsResult;
    pub fn suspend_this_thread(thread_id: u32);
    pub fn wait_for_thread_to_suspend(thread_id: u32);
}
