#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/conll_to_json'

@test "conll_to_json parses conll received on stdin and echos a JSON AST" {
  skip "Not sure exactly what the JSON AST should look like"

  test_conll_to_json() {
    {
      echo "1	When	_	ADV	WRB	_	2	advmod	_	_"
      echo "2	run	_	VERB	VBN	_	4	advcl	_	_"
      echo "3	,	_	.	,	_	4	punct	_	_"
      echo "4	print	_	VERB	VB	_	0	ROOT	_	_"
      echo "5	\`\`	_	.	\`\`	_	7	punct	_	_"
      echo "6	Hello	_	NOUN	NNP	_	7	nn	_	_"
      echo "7	World	_	NOUN	NNP	_	4	dobj	_	_"
      echo "8	''	_	.	''	_	7	punct	_	_"
      echo "9	to	_	ADP	IN	_	4	prep	_	_"
      echo "10	the	_	DET	DT	_	11	det	_	_"
      echo "11	console	_	NOUN	NN	_	9	pobj	_	_"
      echo "12	.	_	.	.	_	4	punct	_	_"
    } | conll_to_json
  }

  run test_conll_to_json

  assert_output '{}'
}
