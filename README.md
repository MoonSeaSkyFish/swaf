# swaf

Small Web Application Framework on jester.

Already install jester.

## How to

```nim
import swaf

route(5555):
  get "/":
    ans "<p>Hello swaf</p>"
  get "/test":
    resp "<p>this is test</p>"
```

access url:

http://localhost:5555


### ans

ans is resp extends. ans is template.

```nim
import swaf

proc testa(): RedirectText =
  RedirectText("https://google.com")
  
route(5555):
  get "/":
    ans """<a href="/redirect">redirect test</a>"""
  get "/redirect":
    ans testa()
```

Access "/redirect" ... redirect "google.com"

ans auto redirect or response.

```nim
proc testa(): ResponseText =
  ResponseText("aaaa")

get "/testa"
  ans testa()
```

covert ...

```nim
get "/testa"
  resp "aaaa"
```

```nim
proc testa(): RedirectText =
  RedirectText("/")

get "/testa"
  ans testa()
```

convert ...

```nim
get "/test"
  redirect "/"
```

```nim
proc testa(): ResponseTextAndCookie =
  result.cookies.add(newCookie(name="name", value="value"))
  result.content = "test cookie"

get "/testa"
  ans testa()
```

convert ...

```nim
get "/test"
  setCookie("name", "value")
  resp "test cookie"
```

### route

route is jester's router easy way. Port or Settings can used easy way.

```nim
route(5555):
  get "/":
    resp "..."
```

convert ...

```nim
router swafRouter:
  get "/":
    resp "..."
let cfg = newSettings(port=Port(5555))
var j = initJester(swafRouter, settings=cfg)
```

```nim
let cfg = newSettings(port=Port(5555), staticDir="./public_html")
route(cfg):
  get "/":
    resp "..."
```

convert ...

```nim
router swafRouter:
  get "/":
    resp "..."
var j = initJester(swafRouter, settings=cfg)
```

## License

Mit license.


