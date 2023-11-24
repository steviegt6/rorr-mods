#[repr(C)]
pub struct SuspendAllThreadsResult {
    pub success: bool,
    pub main_thread: u32,
}

extern "C" {
    pub fn initialize_console();
    pub fn suspend_all_threads() -> SuspendAllThreadsResult;
    pub fn suspend_this_thread(thread_id: u32);
}
