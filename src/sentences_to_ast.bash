sentences_to_ast() {
  node -e '
    const lines = require("readline").createInterface({ input: process.stdin })

    function getAstOfLine(tokensOfLine) {
      return {
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
      }
    }

    lines.on("line", line => {
      const tokensOfLine = JSON.parse(line)
      const astOfLine = getAstOfLine(tokensOfLine)
      console.log(JSON.stringify(astOfLine))
    })
  '
}
