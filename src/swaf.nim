import macros
import swaf/[router, types]
export router, types

template ansTry(stmt: untyped) =
  try:
    stmt
  except:
    resp getCurrentExceptionMsg()

template setCookieList(cooklist: CookieList) =
  for c in cooklist:
    setCookie(c.name, c.value, c.expires,
              domain = c.domain, path = c.path, secure = c.secure)

template ans*(text: string) =
  ansTry:
    resp text

template ans*(text: ResponseText) =
  ansTry:
    resp $text

template ans*(text: RedirectText) =
  ansTry:
    redirect $text

template ans*(data: ResponseTextAndCookie) =
  ansTry:
    setCookieList(data.cookies)
    resp data.content

template ans*(data: RedirectTextAndCookie) =
  ansTry:
    setCookieList(data.cookies)
    redirect data.content

