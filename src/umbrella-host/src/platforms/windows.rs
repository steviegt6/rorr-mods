use windows::{core::PCSTR, Win32::UI::WindowsAndMessaging::MessageBoxA};

pub fn display_message_box(title: &str, message: &str) {
    unsafe {
        MessageBoxA(
            None,
            PCSTR(format!("{}", message).as_ptr()),
            PCSTR(format!("{}", title).as_ptr()),
            windows::Win32::UI::WindowsAndMessaging::MESSAGEBOX_STYLE(0),
        );
    }
}
