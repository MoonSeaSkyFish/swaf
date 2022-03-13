type
  Cookie* = ref object
    name*: string
    value*: string
    expires*: string
    domain*: string
    path*: string
    secure*: bool
  CookieList* = seq[Cookie]

proc newCookie*(name, value: string,
              expires = "", domain = "", path = "",
              secure = false): Cookie =
  Cookie(name: name, value: value, expires: expires,
         domain: domain, path: path, secure: secure)

type
  ResponseText* = distinct string
  RedirectText* = distinct string
  ResponseTextAndCookie* = object
    content*: string
    cookies*: CookieList
  RedirectTextAndCookie* = object
    content*: string
    cookies*: CookieList

proc `$`*(s: ResponseText): string {.borrow.}
proc `$`*(s: RedirectText): string {.borrow.}

type
  InvalidErr* = object of Exception

