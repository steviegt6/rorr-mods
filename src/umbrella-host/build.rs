extern crate cc;

fn main() {
    for_platform(&mut cc::Build::new()).compile("auxiliary");
}

#[cfg(target_os = "windows")]
fn for_platform(build: &mut cc::Build) -> &cc::Build {
    build.file("src/platforms/windows/api_helper.c")
}
