import swaf
import controllers

route(5001):
  get "/":
    ans top()
  get "/deploy":
    ans deploy()
  get "/regist":
    ans regist(request)
  get "/del/@id":
    ans remove(@"id")
