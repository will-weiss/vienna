conll_to_json() {
  awk '
    /^$/ {
      print ""
    }

    /^.+$/ {
      print "{ \"ID\": " $1 ", \"FORM\": \"" $2 "\", \"LEMMA\": \"" $3 "\", \"UPOSTAG\": \"" $4 "\", \"XPOSTAG\": \"" $5 "\", \"FEATS\": \"" $6 "\", \"HEAD\": " $7 ", \"DEPREL\": \"" $8 "\", \"DEPS\": \"" $9 "\", \"MISC\": \"" $(10) "\" }"
    }
  '
}
