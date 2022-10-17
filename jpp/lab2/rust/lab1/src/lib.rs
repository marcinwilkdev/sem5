mod iteratively;
mod reqursively;

pub struct ExtendedEuclideanResult(i32, i32);

pub trait Algorithms {
    fn factorial(number: usize) -> usize;
    fn gcd(first_number: i32, second_number: i32) -> i32;
    fn extended_euclidean_algorithm(
        first_number: i32,
        second_number: i32,
        extended_euclidean_result: &mut ExtendedEuclideanResult,
    );

    #[cfg(test)]
    fn extended_euclidean_algorithm_test_no_zeros(first_number: i32, second_number: i32) {
        let mut extended_euclidean_result = ExtendedEuclideanResult(0, 0);
        Self::extended_euclidean_algorithm(
            first_number,
            second_number,
            &mut extended_euclidean_result,
        );
        assert_eq!(
            (first_number * extended_euclidean_result.0
                + second_number * extended_euclidean_result.1),
            Self::gcd(first_number, second_number)
        );
    }

    #[cfg(test)]
    fn algorithms_test() {
        assert_eq!(Self::factorial(0), 1);
        assert_eq!(Self::factorial(1), 1);
        assert_eq!(Self::factorial(5), 120);
        assert_eq!(Self::factorial(10), 3628800);
        assert_eq!(Self::factorial(15), 1307674368000);

        assert_eq!(Self::gcd(0, 0), 0);
        assert_eq!(Self::gcd(1, 0), 0);
        assert_eq!(Self::gcd(0, 1), 0);
        assert_eq!(Self::gcd(-52, 1), 1);
        assert_eq!(Self::gcd(1, 123), 1);
        assert_eq!(Self::gcd(147, 13), 1);
        assert_eq!(Self::gcd(-839, 60), 1);
        assert_eq!(Self::gcd(52, 13), 13);
        assert_eq!(Self::gcd(248, -94), 2);
        assert_eq!(Self::gcd(8, 6), 2);

        Self::extended_euclidean_algorithm_test_no_zeros(82, 12);
        Self::extended_euclidean_algorithm_test_no_zeros(12, 63);
        Self::extended_euclidean_algorithm_test_no_zeros(8, 15);
        Self::extended_euclidean_algorithm_test_no_zeros(1234, 432);
        Self::extended_euclidean_algorithm_test_no_zeros(90, 5);
    }
}
