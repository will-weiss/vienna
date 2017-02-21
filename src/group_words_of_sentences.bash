group_words_of_sentences() {
  awk '
    /^{.*}$/ {
      sentence = (sentence == "") ? ("[" $0) : (sentence "," $0)
    }

    /^$/ {
      print_sentence_if_present()
    }

    END {
      print_sentence_if_present()
    }

    function print_sentence_if_present() {
      if (sentence == "") return
      print sentence "]"
      sentence = ""
    }
  '
}
