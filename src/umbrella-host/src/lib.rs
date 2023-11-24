use platforms::{initialize_console, set_console_title};

mod platforms;

fn shared_main() {
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

    println!("{}", "test");
}
