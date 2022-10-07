mod fa;
mod kmp;

pub trait PatternSearcher {
    fn search(pattern: &[u8], txt: &[u8]) -> Option<usize>;
}

#[cfg(test)]
pub fn pattern_searcher_test<T>() where T: PatternSearcher {
    let pattern = b"test";
    let txt = b"This is a test.";

    let search_result = <T as PatternSearcher>::search(pattern, txt);
    let expected = Some(10);

    assert_eq!(expected, search_result);

    let pattern = b"Test";
    let txt = b"This is a test.";

    let search_result = <T as PatternSearcher>::search(pattern, txt);
    let expected = None;

    assert_eq!(expected, search_result);

    let pattern = b"TeTest";
    let txt = b"This is a TeTeTest.";

    let search_result = <T as PatternSearcher>::search(pattern, txt);
    let expected = Some(12);

    assert_eq!(expected, search_result);

    let pattern = b"";
    let txt = b"This is a test.";

    let search_result = <T as PatternSearcher>::search(pattern, txt);
    let expected = Some(0);

    assert_eq!(expected, search_result);

    let pattern = b"test";
    let txt = b"";

    let search_result = <T as PatternSearcher>::search(pattern, txt);
    let expected = None;

    assert_eq!(expected, search_result);
}

pub fn run() {

}
