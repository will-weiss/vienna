#! /usr/bin/env bash -euo pipefail

modified_demo_script_contents=$(cat modified_demo.sh)

parse_with_syntax_net() {
  docker run --rm -i brianlow/syntaxnet sh -c "echo '$modified_demo_script_contents' > syntaxnet/demo.sh && syntaxnet/demo.sh"
}

interpret() {
  xargs echo
}

vienna() {
  cat "$1" | parse_with_syntax_net | interpret
}
