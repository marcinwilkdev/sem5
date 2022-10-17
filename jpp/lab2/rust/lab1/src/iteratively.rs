use crate::Algorithms;

pub struct Iteratively;

impl Algorithms for Iteratively {
    fn factorial(number: usize) -> usize {
        let mut factorial_result = 1;

        for factorial_step in 2..=number {
            factorial_result *= factorial_step;
        }

        factorial_result
    }

    fn gcd(mut first_number: i32, mut second_number: i32) -> i32 {
        if first_number == 0 || second_number == 0 {
            return 0;
        }

        if first_number < second_number {
            let tmp = first_number;
            first_number = second_number;
            second_number = tmp;
        }

        while second_number != 0 {
            let tmp = second_number;
            second_number = first_number % second_number;
            first_number = tmp;
        }

        return first_number.abs();
    }

    fn extended_euclidean_algorithm(
        mut first_number: i32,
        mut second_number: i32,
        extended_euclidean_result: &mut crate::ExtendedEuclideanResult,
    ) {
        if first_number == 0 || second_number == 0 {
            extended_euclidean_result.0 = 0;
            extended_euclidean_result.1 = 0;

            return;
        }

        let mut flipped = false;

        if first_number < second_number {
            let tmp_number = first_number;
            first_number = second_number;
            second_number = tmp_number;

            flipped = true;
        }

        let mut first_coefficient = 0;
        let mut second_coefficient = 1;
        let mut remainder = second_number;

        let mut old_first_coefficient = 1;
        let mut old_second_coefficient = 0;
        let mut old_remainder = first_number;

        while remainder != 0 {
            let quotient = old_remainder / remainder;

            let tmp_remainder = remainder;
            remainder = old_remainder - quotient * remainder;
            old_remainder = tmp_remainder;

            let tmp_first_coefficient = first_coefficient;
            first_coefficient = old_first_coefficient - quotient * first_coefficient;
            old_first_coefficient = tmp_first_coefficient;

            let tmp_second_coefficient = second_coefficient;
            second_coefficient = old_second_coefficient - quotient * second_coefficient;
            old_second_coefficient = tmp_second_coefficient;
        }

        if flipped {
            extended_euclidean_result.0 = old_second_coefficient;
            extended_euclidean_result.1 = old_first_coefficient;
        } else {
            extended_euclidean_result.0 = old_first_coefficient;
            extended_euclidean_result.1 = old_second_coefficient;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn iteratively_test() {
        <Iteratively as Algorithms>::algorithms_test();
    }
}
