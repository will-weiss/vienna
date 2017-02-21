#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/parse_english_syntax_trees/parse_english_syntax_trees'

@test "parse_english_syntax_trees parses standard input as english into syntax trees" {
  get_ast_of_english() {
    echo "See Jane run." | parse_english_syntax_trees
  }

  echo_expected_ast() {
    echo '
      { "DEPREL": "ROOT", "FORM": "See", "UPOSTAG": "VERB", "XPOSTAG": "VB", "children": [
        { "DEPREL": "dobj", "FORM": "run", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "children": [
          { "DEPREL": "nn", "FORM": "Jane", "UPOSTAG": "NOUN", "XPOSTAG": "NNP", "children": [] }] },
        { "DEPREL": "punct", "FORM": ".", "UPOSTAG": ".", "XPOSTAG": ".", "children": [] }] }
    '
  }

  stable_json() {
    jq --sort-keys --compact-output '.'
  }

  test_input_to_english_syntax_trees() {
    diff <(get_ast_of_english | stable_json) <(echo_expected_ast | stable_json)
  }

  run test_input_to_english_syntax_trees

  assert_output ''
}
