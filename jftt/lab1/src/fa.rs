use crate::PatternSearcher;

pub struct Fa;

impl PatternSearcher for Fa {
    fn search(pattern: &[u8], txt: &[u8]) -> Option<usize> {
        if pattern.len() == 0 && txt.len() > 0 {
            return Some(0);
        }

        let lookup_table = prepare_table(pattern);
        let mut matched = 0;

        for idx in 0..txt.len() {
            let byte = txt[idx];
            matched = lookup_table[matched][byte as usize];

            if matched == pattern.len() {
                return Some(idx - (pattern.len() - 1));
            }
        }

        None
    }
}

fn suffix_to_prefix_match(pattern: &[u8], matched_count: usize, curr_matched_count: usize, byte: u8) -> bool {
    let offset = matched_count + 1 - curr_matched_count;

    if pattern[curr_matched_count - 1] != byte {
        return false;
    }

    for idx in 0..curr_matched_count - 1 {
        if pattern[idx] != pattern[offset + idx] {
            return false;
        }
    }

    true
}

fn prepare_table(pattern: &[u8]) -> Vec<[usize; 256]> {
    let mut lookup_table: Vec<[usize; 256]> = vec![[0; 256]; pattern.len()];

    for matched_count in 0..pattern.len() {
        for byte in 0..=u8::MAX {
            let mut curr_matched_count = matched_count + 1;

            while curr_matched_count > 0
                && !suffix_to_prefix_match(pattern, matched_count, curr_matched_count, byte)
            {
                curr_matched_count -= 1;
            }

            lookup_table[matched_count][byte as usize] = curr_matched_count;
        }
    }

    lookup_table
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn fa_test() {
        crate::pattern_searcher_test::<Fa>();
    }
}
