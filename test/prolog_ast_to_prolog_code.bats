#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/prolog_ast_to_prolog_code'

@test "prolog_ast_to_prolog_code converts a simple AST representing a prolog program to prolog code" {
  echo_prolog_ast() {
    echo '{
      "type": "program",
      "clauses": [
        {
          "type": "predicate",
          "name": "format",
          "arguments": [
            {
              "type": "string",
              "value": "~s~n"
            },
            {
              "type": "list",
              "contents": [
                {
                  "type": "string",
                  "value": "Woah"
                }
              ]
            }
          ]
        }
      ]
    }' | jq --compact-output '.'
  }

  test_prolog_ast_to_prolog_code() {
    echo_prolog_ast | prolog_ast_to_prolog_code
  }

  run test_prolog_ast_to_prolog_code

  assert_output 'format("~s~n", ["Woah"]).'
}
