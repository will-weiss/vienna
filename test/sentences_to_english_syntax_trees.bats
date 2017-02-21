#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/sentences_to_english_syntax_trees'

@test "sentences_to_english_syntax_trees converts arrays of JSON records containing information about words in a sentence to syntax trees representing those english sentences." {

  echo_tokens() {
    echo '{ "ID": 1, "FORM": "When", "LEMMA": "_", "UPOSTAG": "ADV", "XPOSTAG": "WRB", "FEATS": "_", "HEAD": 2, "DEPREL": "advmod", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 2, "FORM": "run", "LEMMA": "_", "UPOSTAG": "VERB", "XPOSTAG": "VBN", "FEATS": "_", "HEAD": 4, "DEPREL": "advcl", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 3, "FORM": ",", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": ",", "FEATS": "_", "HEAD": 4, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 4, "FORM": "print", "LEMMA": "_", "UPOSTAG": "VERB", "XPOSTAG": "VB", "FEATS": "_", "HEAD": 0, "DEPREL": "ROOT", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 5, "FORM": "the", "LEMMA": "_", "UPOSTAG": "DET", "XPOSTAG": "DT", "FEATS": "_", "HEAD": 6, "DEPREL": "det", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 6, "FORM": "message", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "FEATS": "_", "HEAD": 4, "DEPREL": "dobj", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 7, "FORM": "to", "LEMMA": "_", "UPOSTAG": "ADP", "XPOSTAG": "IN", "FEATS": "_", "HEAD": 4, "DEPREL": "prep", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 8, "FORM": "the", "LEMMA": "_", "UPOSTAG": "DET", "XPOSTAG": "DT", "FEATS": "_", "HEAD": 9, "DEPREL": "det", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 9, "FORM": "console", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "FEATS": "_", "HEAD": 7, "DEPREL": "pobj", "DEPS": "_", "MISC": "_" }'
    echo '{ "ID": 10, "FORM": ".", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": ".", "FEATS": "_", "HEAD": 4, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }'
  }

  get_ast_of_tokens() {
    echo_tokens | jq --compact-output --slurp '.' | sentences_to_english_syntax_trees
  }

  echo_expected_ast() {
    echo '
      { "FORM": "print", "UPOSTAG": "VERB", "XPOSTAG": "VB", "DEPREL": "ROOT", "children": [
        { "FORM": "run", "UPOSTAG": "VERB", "XPOSTAG": "VBN", "DEPREL": "advcl", "children": [
          { "FORM": "When", "UPOSTAG": "ADV", "XPOSTAG": "WRB", "DEPREL": "advmod", "children": [] }] },
        { "FORM": ",", "UPOSTAG": ".", "XPOSTAG": ",", "DEPREL": "punct", "children": [] },
        { "FORM": "message", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "DEPREL": "dobj", "children": [
          { "FORM": "the", "UPOSTAG": "DET", "XPOSTAG": "DT", "DEPREL": "det", "children": [] }] },
        { "FORM": "to", "UPOSTAG": "ADP", "XPOSTAG": "IN", "DEPREL": "prep", "children": [
          { "FORM": "console", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "DEPREL": "pobj", "children": [
            { "FORM": "the", "UPOSTAG": "DET", "XPOSTAG": "DT", "DEPREL": "det", "children": [] }] }] },
        { "FORM": ".", "UPOSTAG": ".", "XPOSTAG": ".", "DEPREL": "punct", "children": [] }] }
    '
  }

  stable_json() {
    jq --sort-keys --compact-output '.'
  }

  test_sentences_to_english_syntax_trees() {
    diff <(get_ast_of_tokens | stable_json) <(echo_expected_ast | stable_json)
  }

  run test_sentences_to_english_syntax_trees

  assert_output ''
}
