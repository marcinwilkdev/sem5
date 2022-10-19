fn main() {
    // cc::Build::new().file("c/lib_req.c").compile("lib_req");
    cc::Build::new().file("c/lib.c").compile("lib");
}
