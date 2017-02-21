english_syntax_trees_to_prolog_ast() {
  # Read and discard lines for now
  while read line; do
    :
  done

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
                "value": "Hello World"
              }
            ]
          }
        ]
      }
    ]
  }' | jq --compact-output '.'
}