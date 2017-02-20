#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'



@test "When vienna runs a file that indicates that the message \"Hello World\" should be printed to the console, \"Hello World\" is printed to the console" {
  skip "Lots to do before this will work"
  run $BATS_TEST_DIRNAME/../vienna $BATS_TEST_DIRNAME/hello_world.vn
  assert_output "Hello World"
}
