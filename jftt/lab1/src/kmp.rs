use crate::PatternSearcher;

pub struct Kmp;

impl PatternSearcher for Kmp {
    fn search(pattern: &[u8], txt: &[u8]) -> Option<usize> {
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn kmp_test() {
        crate::pattern_searcher_test::<Kmp>();
    }
}
