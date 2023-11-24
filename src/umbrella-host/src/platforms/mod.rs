#![allow(dead_code)]

#[cfg(target_os = "windows")]
pub mod windows;

#[cfg(target_os = "macos")]
pub mod macos;

#[cfg(target_os = "linux")]
pub mod linux;

pub fn display_message_box(title: &str, message: &str) {
    #[cfg(target_os = "windows")]
    windows::display_message_box(title, message);

    #[cfg(target_os = "macos")]
    macos::display_message_box(title, message);

    #[cfg(target_os = "linux")]
    linux::display_message_box(title, message);
}

pub fn initialize_console() {
    #[cfg(target_os = "windows")]
    windows::initialize_console();

    #[cfg(target_os = "macos")]
    macos::initialize_console();

    #[cfg(target_os = "linux")]
    linux::initialize_console();
}

pub fn set_console_title(title: &str) {
    #[cfg(target_os = "windows")]
    windows::set_console_title(title);

    #[cfg(target_os = "macos")]
    macos::set_console_title(title);

    #[cfg(target_os = "linux")]
    linux::set_console_title(title);
}

pub fn is_process_suspended() -> bool {
    #[cfg(target_os = "windows")]
    return windows::is_suspended_process();

    #[cfg(target_os = "macos")]
    return macos::is_suspended_process();

    #[cfg(target_os = "linux")]
    return linux::is_suspended_process();
}

pub fn restart_process_as_suspended(p: *mut ::core::ffi::c_void) {
    #[cfg(target_os = "windows")]
    windows::restart_process_as_suspended(p);

    #[cfg(target_os = "macos")]
    macos::restart_process_as_suspended(p);

    #[cfg(target_os = "linux")]
    linux::restart_process_as_suspended(p);
}
