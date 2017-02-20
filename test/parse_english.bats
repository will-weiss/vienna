#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/parse_english'

@test "parse_english parses standard input into a conll representation of the parsed syntax" {
  test_parse_english() {
    cat $BATS_TEST_DIRNAME/hello_world.vn | parse_english
  }

  run test_parse_english

  assert_line --index 0 "1	When	_	ADV	WRB	_	2	advmod	_	_"
  assert_line --index 1 "2	run	_	VERB	VBN	_	4	advcl	_	_"
  assert_line --index 2 "3	,	_	.	,	_	4	punct	_	_"
  assert_line --index 3 "4	print	_	VERB	VB	_	0	ROOT	_	_"
  assert_line --index 4 "5	\`\`	_	.	\`\`	_	7	punct	_	_"
  assert_line --index 5 "6	Hello	_	NOUN	NNP	_	7	nn	_	_"
  assert_line --index 6 "7	World	_	NOUN	NNP	_	4	dobj	_	_"
  assert_line --index 7 "8	''	_	.	''	_	7	punct	_	_"
  assert_line --index 8 "9	to	_	ADP	IN	_	4	prep	_	_"
  assert_line --index 9 "10	the	_	DET	DT	_	11	det	_	_"
  assert_line --index 10 "11	console	_	NOUN	NN	_	9	pobj	_	_"
  assert_line --index 11 "12	.	_	.	.	_	4	punct	_	_"

  assert_equal "${#lines[@]}" 12
}
