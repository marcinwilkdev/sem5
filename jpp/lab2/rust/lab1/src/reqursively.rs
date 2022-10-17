use crate::Algorithms;

struct ExtendedEuclideanData {
    first_coefficient: i32,
    second_coefficient: i32,
    remainder: i32,
    old_first_coefficient: i32,
    old_second_coefficient: i32,
    old_remainder: i32,
}

pub struct Reqursively;

impl Reqursively {
    fn factorial_req(number: usize, acc: usize) -> usize {
        if number == 0 {
            return acc;
        }

        return Reqursively::factorial_req(number - 1, number * acc);
    }

    fn gcd_req(first_number: i32, second_number: i32) -> i32 {
        if second_number == 0 {
            return first_number;
        }

        Reqursively::gcd_req(second_number, first_number % second_number)
    }

    fn extended_euclidean_req(extended_euclidean_data: &mut ExtendedEuclideanData) {
        if extended_euclidean_data.remainder == 0 {
            return;
        }

        let quotient = extended_euclidean_data.old_remainder / extended_euclidean_data.remainder;

        let tmp_remainder = extended_euclidean_data.remainder;
        extended_euclidean_data.remainder =
            extended_euclidean_data.old_remainder - quotient * extended_euclidean_data.remainder;
        extended_euclidean_data.old_remainder = tmp_remainder;

        let tmp_first_coefficient = extended_euclidean_data.first_coefficient;
        extended_euclidean_data.first_coefficient = extended_euclidean_data.old_first_coefficient
            - quotient * extended_euclidean_data.first_coefficient;
        extended_euclidean_data.old_first_coefficient = tmp_first_coefficient;

        let tmp_second_coefficient = extended_euclidean_data.second_coefficient;
        extended_euclidean_data.second_coefficient = extended_euclidean_data.old_second_coefficient
            - quotient * extended_euclidean_data.second_coefficient;
        extended_euclidean_data.old_second_coefficient = tmp_second_coefficient;

        Reqursively::extended_euclidean_req(extended_euclidean_data);
    }
}

impl Algorithms for Reqursively {
    fn factorial(number: usize) -> usize {
        Reqursively::factorial_req(number, 1)
    }

    fn gcd(first_number: i32, second_number: i32) -> i32 {
        if first_number == 0 || second_number == 0 {
            return 0;
        }

        if first_number < second_number {
            return Reqursively::gcd_req(second_number, first_number).abs();
        } else {
            return Reqursively::gcd_req(first_number, second_number).abs();
        }
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

        let mut extended_euclidean_data = ExtendedEuclideanData {
            first_coefficient: 0,
            second_coefficient: 1,
            remainder: second_number,
            old_first_coefficient: 1,
            old_second_coefficient: 0,
            old_remainder: first_number,
        };

        Reqursively::extended_euclidean_req(&mut extended_euclidean_data);

        if flipped {
            extended_euclidean_result.0 = extended_euclidean_data.old_second_coefficient;
            extended_euclidean_result.1 = extended_euclidean_data.old_first_coefficient;
        } else {
            extended_euclidean_result.0 = extended_euclidean_data.old_first_coefficient;
            extended_euclidean_result.1 = extended_euclidean_data.old_second_coefficient;
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn iteratively_test() {
        <Reqursively as Algorithms>::algorithms_test();
    }
}
