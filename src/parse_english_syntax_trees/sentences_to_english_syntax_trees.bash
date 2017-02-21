sentences_to_english_syntax_trees() {
  node -e '
    require("readline")
      .createInterface({ input: process.stdin })
      .on("line", printSyntaxTreeOfLine)

    function printSyntaxTreeOfLine(line) {
      const wordsOfSentence = JSON.parse(line)
      const englishSyntaxTreeOfSentence = getEnglishSyntaxTreeOfSentence(wordsOfSentence)
      console.log(JSON.stringify(englishSyntaxTreeOfSentence))
    }

    function getEnglishSyntaxTreeOfSentence(wordsOfSentence) {
      const childrenOfWord = ID =>
        wordsOfSentence
          .filter(wordOfSentence => wordOfSentence.HEAD === ID)
          .map(formSyntaxTreeOfWord)

      const formSyntaxTreeOfWord = ({ ID, FORM, UPOSTAG, XPOSTAG, DEPREL }) =>
        ({ FORM, UPOSTAG, XPOSTAG, DEPREL, children: childrenOfWord(ID) })

      const rootWord = wordsOfSentence.find(word => word.DEPREL === "ROOT")

      return formSyntaxTreeOfWord(rootWord);
    }
  '
}
