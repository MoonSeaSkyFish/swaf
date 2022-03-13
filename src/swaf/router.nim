import macros
import jester
import jester/private/utils
export jester

macro routeSub(cfg: Settings, stmt: untyped): untyped =
  let stmt = newStmtList(
    nnkCommand.newTree(
      newIdentNode("router"),
      newIdentNode("swafRouter"),
      stmt
    )
  )
  quote do:
    `stmt`
    var j = initJester(swafRouter, settings = `cfg`)
    j.serve()

macro route*(cfg: Settings, stmt: untyped): untyped =
  getAST(routeSub(cfg, stmt))

macro route*(port: int, stmt: untyped): untyped =
  let cfg = quote do:
    newSettings(port = Port(`port`))
  getAST(routeSub(cfg, stmt))



