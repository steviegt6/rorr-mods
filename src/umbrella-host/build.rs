extern crate cc;

fn main() {
    let mut build = cc::Build::new();
    for_platform(&mut build);
    build.compile("evil");
}

#[cfg(target_os = "windows")]
fn for_platform(build: &mut cc::Build) {
    build
        .file("src/platforms/windows/evil.c")
        .file("src/platforms/windows/suspended.c");
}
