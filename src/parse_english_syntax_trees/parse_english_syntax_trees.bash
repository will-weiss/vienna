source src/parse_english_syntax_trees/parse_english_to_conll.bash
source src/parse_english_syntax_trees/conll_words_to_json_words.bash
source src/parse_english_syntax_trees/group_words_of_sentences.bash
source src/parse_english_syntax_trees/sentences_to_english_syntax_trees.bash


parse_english_syntax_trees() {
  parse_english_to_conll \
    | conll_words_to_json_words \
    | group_words_of_sentences \
    | sentences_to_english_syntax_trees
}
