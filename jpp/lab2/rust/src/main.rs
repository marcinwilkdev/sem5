extern "C" {
    fn addOne(a: i32) -> i32;
}

fn main() {
    unsafe { addOne(5) };
    println!("A");
}
