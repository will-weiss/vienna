#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

@test "When vienna runs a file, that indicates that the message \"Hello World\" should be printed to the console, \"Hello World\" is printed to the console" {
  run vienna hello_world.vn
  assert_output "Hello World"
}