#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/parse_english_syntax_trees/conll_words_to_json_words'

@test "conll_words_to_json_words parses words represented as lines in conll format received on stdin and echos a JSON record for each word. When an empty line is received, an empty line is output." {

  test_conll_words_to_json_words() {
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
      echo ""
    } | conll_words_to_json_words
  }

  run test_conll_words_to_json_words

  assert_line --index 0 '{ "ID": 1, "FORM": "When", "LEMMA": "_", "UPOSTAG": "ADV", "XPOSTAG": "WRB", "FEATS": "_", "HEAD": 2, "DEPREL": "advmod", "DEPS": "_", "MISC": "_" }'
  assert_line --index 1 '{ "ID": 2, "FORM": "run", "LEMMA": "_", "UPOSTAG": "VERB", "XPOSTAG": "VBN", "FEATS": "_", "HEAD": 4, "DEPREL": "advcl", "DEPS": "_", "MISC": "_" }'
  assert_line --index 2 '{ "ID": 3, "FORM": ",", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": ",", "FEATS": "_", "HEAD": 4, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }'
  assert_line --index 3 '{ "ID": 4, "FORM": "print", "LEMMA": "_", "UPOSTAG": "VERB", "XPOSTAG": "VB", "FEATS": "_", "HEAD": 0, "DEPREL": "ROOT", "DEPS": "_", "MISC": "_" }'
  assert_line --index 4 '{ "ID": 5, "FORM": "``", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": "``", "FEATS": "_", "HEAD": 7, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }'
  assert_line --index 5 '{ "ID": 6, "FORM": "Hello", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NNP", "FEATS": "_", "HEAD": 7, "DEPREL": "nn", "DEPS": "_", "MISC": "_" }'
  assert_line --index 6 '{ "ID": 7, "FORM": "World", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NNP", "FEATS": "_", "HEAD": 4, "DEPREL": "dobj", "DEPS": "_", "MISC": "_" }'
  assert_line --index 7 '{ "ID": 8, "FORM": "'"''"'", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": "'"''"'", "FEATS": "_", "HEAD": 7, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }'
  assert_line --index 8 '{ "ID": 9, "FORM": "to", "LEMMA": "_", "UPOSTAG": "ADP", "XPOSTAG": "IN", "FEATS": "_", "HEAD": 4, "DEPREL": "prep", "DEPS": "_", "MISC": "_" }'
  assert_line --index 9 '{ "ID": 10, "FORM": "the", "LEMMA": "_", "UPOSTAG": "DET", "XPOSTAG": "DT", "FEATS": "_", "HEAD": 11, "DEPREL": "det", "DEPS": "_", "MISC": "_" }'
  assert_line --index 10 '{ "ID": 11, "FORM": "console", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "FEATS": "_", "HEAD": 9, "DEPREL": "pobj", "DEPS": "_", "MISC": "_" }'
  assert_line --index 11 '{ "ID": 12, "FORM": ".", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": ".", "FEATS": "_", "HEAD": 4, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }'
  assert_line --index 12 ''
}
