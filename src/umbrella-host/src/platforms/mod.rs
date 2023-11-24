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
