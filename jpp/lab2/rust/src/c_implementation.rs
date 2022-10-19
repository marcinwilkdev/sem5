use crate::{Algorithms, ExtendedEuclideanResult};

#[repr(C)]
struct Pair {
    first_number: i32,
    second_number: i32,
}

extern "C" {
    fn factorial(number: usize) -> usize;
    fn gcd(first_number: i32, second_number: i32) -> i32;
    fn extendedEuclidean(
        first_number: i32,
        second_number: i32,
        third_number: i32,
        result: *mut Pair,
    ) -> i32;
}

struct CImplementation;

impl Algorithms for CImplementation {
    fn factorial(number: usize) -> usize {
        unsafe { factorial(number) }
    }

    fn gcd(first_number: i32, second_number: i32) -> i32 {
        unsafe { gcd(first_number, second_number) }
    }

    fn extended_euclidean_algorithm(
        first_number: i32,
        second_number: i32,
        third_number: i32,
        extended_euclidean_result: &mut ExtendedEuclideanResult,
    ) -> bool {
        let mut result = Pair {
            first_number: 0,
            second_number: 0,
        };

        let success =
            unsafe { extendedEuclidean(first_number, second_number, third_number, &mut result) };

        extended_euclidean_result.0 = result.first_number;
        extended_euclidean_result.1 = result.second_number;

        success == 0
    }
}


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn cimplementation_test() {
        <CImplementation as Algorithms>::algorithms_test();
    }
}

