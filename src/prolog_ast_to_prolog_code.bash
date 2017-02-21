prolog_ast_to_prolog_code() {
  node -e '
    require("readline")
      .createInterface({ input: process.stdin })
      .on("line", printPrologCodeForLine)

    function printPrologCodeForLine(line) {
      const ast = JSON.parse(line)
      const prologCodeForLine = getPrologCodeOfNode(ast)
      console.log(prologCodeForLine)
    }

    function getPrologCodeOfNode(node) {
      switch (node.type) {
        case "program": {
          return node.clauses.map(getPrologCodeOfNode).join(" ")
        }
        case "predicate": {
          return node.name + "(" + node.arguments.map(getPrologCodeOfNode).join(", ") + ")."
        }
        case "string": {
          return "\"" + node.value + "\""
        }
        case "list": {
          return "[" + node.contents.map(getPrologCodeOfNode).join(", ") + "]"
        }
        default: {
          throw new Error("Unrecognized node type: " + node.type)
        }
      }
    }
  '
}