import swaf
import htmlgen

route(5555):
  get "/":
    ans `div`(
      p("hello world!"),
      p(a(href = "/test", "test")))
  get "/test":
    ans `div`(
      p("ok test!"),
      p(a(href = "/test/12345", "test 12345")))
  get "/test/@id":
    ans `div`(
      p("ok test id = " & @"id"),
      p(a(href = "/", "top page")))


