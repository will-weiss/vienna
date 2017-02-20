#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/prolog_interpreter'

@test "Runs prolog received on stdin" {
  test_prolog_interpreter() {
    echo 'format("~s~n", ["Hello World"]).' | prolog_interpreter
  }

  run test_prolog_interpreter

  assert_output "Hello World"
}
