sentences_to_ast() {
  node -e '
    const lines = require("readline").createInterface({ input: process.stdin })

    function getAstOfLine(tokensOfLine) {
      const root = tokensOfLine.find(token => token.HEAD === 0)

      function findChildren({ ID, FORM, XPOSTAG, DEPREL }) {
        const children = tokensOfLine
          .filter(otherToken => otherToken.HEAD === ID)
          .map(findChildren)
        
        return { FORM, XPOSTAG, DEPREL, children }
      }

      return findChildren(root);
    }

    lines.on("line", line => {
      const tokensOfLine = JSON.parse(line)
      const astOfLine = getAstOfLine(tokensOfLine)
      console.log(JSON.stringify(astOfLine))
    })
  '
}
