conll_to_json() {
  awk '
    /^$/ {
      print ""
    }

    /^.+$/ {
      print "{ " json_pair(       "ID",      $1)  \
            ", " json_quoted_pair("FORM",    $2)  \
            ", " json_quoted_pair("LEMMA",   $3)  \
            ", " json_quoted_pair("UPOSTAG", $4)  \
            ", " json_quoted_pair("XPOSTAG", $5)  \
            ", " json_quoted_pair("FEATS",   $6)  \
            ", " json_pair(       "HEAD",    $7)  \
            ", " json_quoted_pair("DEPREL",  $8)  \
            ", " json_quoted_pair("DEPS",    $9)  \
            ", " json_quoted_pair("MISC",    $10) \
            " }"
    }

    function json_pair(key, value) {
      return ("\"" key "\": " value)
    }

    function json_quoted_pair(key, value) {
      return json_pair(key, "\"" value "\"")
    }
  '
}
