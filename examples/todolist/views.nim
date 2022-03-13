import htmlgen
import strformat
import strutils
import models

proc defaultHtml(content: string): string =
  result = fmt"""
<!doctype html>
<html lang="ja">
  <head>
    <meta charset="utf-8">
    <title>TODO LIST</title>
  </head>
  <body>
{(indent(content, 4))}
  </body>
</html>
"""

proc topPage*(tasks: seq[Task]): string =
  let content = fmt"""
<form action="/regist">
  <input type="text" name="task" length="26"><button>Regist</button>
</form>
<ul>
{(block:
    var li: string
    for task in tasks:
      li.add(indent(li(task.task & " " & a(href="/del/" & $task.id, "del")), 2) & "\n")
    li
)}</ul>"""
  result = defaultHtml(content)

proc messagePage*(message: string): string =
  result = defaultHtml(fmt"""<p class="message">{message}</p>""")
