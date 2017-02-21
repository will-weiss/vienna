#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/parse_english_syntax_trees/group_words_of_sentences'

@test "group_words_of_sentences groups JSON objects representing words of sentences into JSON arrays. It interprets empty lines as sentence breaks and outputs one array per sentence." {

  test_group_words_of_sentences() {
    {
      echo '{ "ID": 1, "FORM": "I" }'
      echo '{ "ID": 2, "FORM": "do" }'
      echo '{ "ID": 3, "FORM": "." }'
      echo
      echo '{ "ID": 1, "FORM": "They" }'
      echo '{ "ID": 2, "FORM": "would" }'
      echo '{ "ID": 3, "FORM": "." }'
      echo
    } | group_words_of_sentences
  }

  run test_group_words_of_sentences

  assert_line --index 0 '[{ "ID": 1, "FORM": "I" },{ "ID": 2, "FORM": "do" },{ "ID": 3, "FORM": "." }]'
  assert_line --index 1 '[{ "ID": 1, "FORM": "They" },{ "ID": 2, "FORM": "would" },{ "ID": 3, "FORM": "." }]'
  
  assert_equal "${#lines[@]}" 2
}
