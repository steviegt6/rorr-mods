use platforms::{initialize_console, set_console_title};

mod platforms;

#[cfg(target_os = "windows")]
const OS: &str = "Windows";

#[cfg(target_os = "macos")]
const OS: &str = "macOS";

#[cfg(target_os = "linux")]
const OS: &str = "Linux";

#[cfg(target_arch = "x86")]
const ARCH: &str = "x86";

#[cfg(target_arch = "x86_64")]
const ARCH: &str = "x86_64";

#[cfg(target_arch = "arm")]
const ARCH: &str = "arm";

#[cfg(target_arch = "aarch64")]
const ARCH: &str = "aarch64";

#[cfg(debug_assertions)]
const BUILD_TYPE: &str = "DEBUG";

#[cfg(not(debug_assertions))]
const BUILD_TYPE: &str = "RELEASE";

fn shared_main() {
    initialize_console();

    set_console_title(&format!(
        "Tomat.Umbrella.Host v{} - {} {} ({})",
        env!("CARGO_PKG_VERSION"),
        OS,
        ARCH,
        BUILD_TYPE
    ));

    println!(
        "Tomat.Umbrella.Host v{} - {} {} ({}) by tomat (steviegt6)",
        env!("CARGO_PKG_VERSION"),
        OS,
        ARCH,
        BUILD_TYPE
    );
    println!("    The Umbrella API and associated projects are and always will be free software.");
    println!("    That's \"free\" as in \"free beer\" *and* \"freedom.\"");
    println!("    If you appeciate what I do, consider donating; it supports me and promotes the longevity of this project:");
    println!("        - https://patreon.com/tomatophile");
    println!("        - https://ko-fi.com/tomatophile");
    println!("This project is made possible by many people, including:");
    println!("    - tomat (myself),");
    println!("    - the folks over at https://github.com/AurieFramework (namely Archie),");
    println!("    - any and all contributors to The Umbrella API,");
    println!("    - and anyone else using or supporting this software (that means you!).");
    println!("The following pieces of software are related to or have been referenced in the creation of this project:");
    println!("    - https://github.com/steviegt6/rorr-mods (the repo in which The Umbrella API resides),");
    println!("    - https://store.steampowered.com/app/1337520/Risk_of_Rain_Returns/,");
    println!("    - and repositories under the https://github.com/AurieFramework/ organization.");
}
