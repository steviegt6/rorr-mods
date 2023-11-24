use platforms::{initialize_console, set_console_title};

use crate::platforms::display_message_box;

mod platforms;

fn shared_main(p: *mut ::core::ffi::c_void) {
    initialize_console();

    #[cfg(target_os = "windows")]
    let os = "Windows";

    #[cfg(target_os = "macos")]
    let os = "macOS";

    #[cfg(target_os = "linux")]
    let os = "Linux";

    #[cfg(target_arch = "x86")]
    let arch = "x86";

    #[cfg(target_arch = "x86_64")]
    let arch = "x86_64";

    #[cfg(target_arch = "arm")]
    let arch = "arm";

    #[cfg(target_arch = "aarch64")]
    let arch = "aarch64";

    #[cfg(debug_assertions)]
    let build_type = "DEBUG";

    #[cfg(not(debug_assertions))]
    let build_type = "RELEASE";

    set_console_title(&format!(
        "Tomat.Umbrella.Host v{} - {} {} ({})",
        env!("CARGO_PKG_VERSION"),
        os,
        arch,
        build_type
    ));

    let suspended = platforms::is_process_suspended();
    println!("Launched as suspended process: {}", suspended);

    if !suspended {
        platforms::restart_process_as_suspended(p);
        return;
    }

    display_message_box("hi", "yay it's suspended")
}
