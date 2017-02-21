#! /usr/bin/env bash -e

which docker >/dev/null || {
  echo "Download docker for mac here"
  echo "https://www.docker.com/products/docker"
  exit 1
}

which brew >/dev/null || {
  echo "Install Homebrew by following the instructions here"
  echo "https://brew.sh/"
  exit 1
}

which jq >/dev/null || {
  brew install jq
}

which bats >/dev/null || {
  brew install bats
}

which swipl >/dev/null || {
  brew install swi-prolog
}
