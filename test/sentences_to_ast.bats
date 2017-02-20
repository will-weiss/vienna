#! /usr/bin/env bats

load './test_helper/bats-support/load'
load './test_helper/bats-assert/load'
load './test_helper/bats-file/load'

load '../src/sentences_to_ast'

@test "sentences_to_ast does something" {
  test_sentences_to_ast() {
    echo '[{ "ID": 1, "FORM": "When", "LEMMA": "_", "UPOSTAG": "ADV", "XPOSTAG": "WRB", "FEATS": "_", "HEAD": 2, "DEPREL": "advmod", "DEPS": "_", "MISC": "_" },{ "ID": 2, "FORM": "run", "LEMMA": "_", "UPOSTAG": "VERB", "XPOSTAG": "VBN", "FEATS": "_", "HEAD": 4, "DEPREL": "advcl", "DEPS": "_", "MISC": "_" },{ "ID": 3, "FORM": ",", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": ",", "FEATS": "_", "HEAD": 4, "DEPREL": "punct", "DEPS": "_", "MISC": "_" },{ "ID": 4, "FORM": "print", "LEMMA": "_", "UPOSTAG": "VERB", "XPOSTAG": "VB", "FEATS": "_", "HEAD": 0, "DEPREL": "ROOT", "DEPS": "_", "MISC": "_" },{ "ID": 5, "FORM": "the", "LEMMA": "_", "UPOSTAG": "DET", "XPOSTAG": "DT", "FEATS": "_", "HEAD": 6, "DEPREL": "det", "DEPS": "_", "MISC": "_" },{ "ID": 6, "FORM": "message", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "FEATS": "_", "HEAD": 4, "DEPREL": "dobj", "DEPS": "_", "MISC": "_" },{ "ID": 7, "FORM": "to", "LEMMA": "_", "UPOSTAG": "ADP", "XPOSTAG": "IN", "FEATS": "_", "HEAD": 4, "DEPREL": "prep", "DEPS": "_", "MISC": "_" },{ "ID": 8, "FORM": "the", "LEMMA": "_", "UPOSTAG": "DET", "XPOSTAG": "DT", "FEATS": "_", "HEAD": 9, "DEPREL": "det", "DEPS": "_", "MISC": "_" },{ "ID": 9, "FORM": "console", "LEMMA": "_", "UPOSTAG": "NOUN", "XPOSTAG": "NN", "FEATS": "_", "HEAD": 7, "DEPREL": "pobj", "DEPS": "_", "MISC": "_" },{ "ID": 10, "FORM": ".", "LEMMA": "_", "UPOSTAG": ".", "XPOSTAG": ".", "FEATS": "_", "HEAD": 4, "DEPREL": "punct", "DEPS": "_", "MISC": "_" }]' | sentences_to_ast | jq '.'
  }

  run test_sentences_to_ast

  assert_output '{
  "FORM": "print",
  "XPOSTAG": "VB",
  "DEPREL": "ROOT",
  "children": [
    {
      "FORM": "run",
      "XPOSTAG": "VBN",
      "DEPREL": "advcl",
      "children": [
        {
          "FORM": "When",
          "XPOSTAG": "WRB",
          "DEPREL": "advmod",
          "children": []
        }
      ]
    },
    {
      "FORM": ",",
      "XPOSTAG": ",",
      "DEPREL": "punct",
      "children": []
    },
    {
      "FORM": "message",
      "XPOSTAG": "NN",
      "DEPREL": "dobj",
      "children": [
        {
          "FORM": "the",
          "XPOSTAG": "DT",
          "DEPREL": "det",
          "children": []
        }
      ]
    },
    {
      "FORM": "to",
      "XPOSTAG": "IN",
      "DEPREL": "prep",
      "children": [
        {
          "FORM": "console",
          "XPOSTAG": "NN",
          "DEPREL": "pobj",
          "children": [
            {
              "FORM": "the",
              "XPOSTAG": "DT",
              "DEPREL": "det",
              "children": []
            }
          ]
        }
      ]
    },
    {
      "FORM": ".",
      "XPOSTAG": ".",
      "DEPREL": "punct",
      "children": []
    }
  ]
}'
}

