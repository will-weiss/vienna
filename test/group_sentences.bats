#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/group_sentences'

@test "group_sentences groups words into sentences" {

  test_group_sentences() {
    {
      echo '{ "ID": 1, "FORM": "I" }'
      echo '{ "ID": 2, "FORM": "do" }'
      echo '{ "ID": 3, "FORM": "." }'
      echo
      echo '{ "ID": 1, "FORM": "They" }'
      echo '{ "ID": 2, "FORM": "would" }'
      echo '{ "ID": 3, "FORM": "." }'
      echo
    } | group_sentences
  }

  run test_group_sentences

  assert_line --index 0 '[{ "ID": 1, "FORM": "I" },{ "ID": 2, "FORM": "do" },{ "ID": 3, "FORM": "." }]'
  assert_line --index 1 '[{ "ID": 1, "FORM": "They" },{ "ID": 2, "FORM": "would" },{ "ID": 3, "FORM": "." }]'
  
  assert_equal "${#lines[@]}" 2
}
