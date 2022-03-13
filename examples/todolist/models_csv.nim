import parsecsv, strutils

const CSV_FILE = "todo.csv"

type
  Task* = ref object
    id*: int
    task*: string

proc newTask(id: int, task: string): Task =
  Task(id: id, task: task)

proc csvEscape(s: string): string =
  "\"" & s.replace("\"", "\"\"") & "\""

proc initModel*() =
  writeFile(CSV_FILE, "id,task")

proc loadTasks(): seq[Task] =
  var p: CsvParser
  try:
    p.open(CSV_FILE)
  except IOError:
    writeFile(CSV_FILE, "id,task")
    p.open(CSV_FILE)
  defer: p.close
  p.readHeaderRow()
  while p.readRow():
    result.add(newTask(parseInt(p.rowEntry("id")), p.rowEntry("task")))

proc writeTasks(tasks: seq[Task]) =
  var f = open(CSV_FILE, FileMode.fmWrite)
  defer: f.close
  f.writeLine("id,task")
  for t in tasks:
    f.writeLine($t.id & "," & csvEscape(t.task))

proc addTask*(task: string) =
  var tasks = loadTasks()
  var id = 0
  for t in tasks:
    if id < t.id:
      id = t.id
  id.inc
  tasks.add(newTask(id = id, task = task))
  writeTasks(tasks)

proc delTask*(id: int) =
  var tasks = loadTasks()
  var idx = 0
  for t in tasks:
    if t.id == id:
      tasks.delete(idx)
      break
    idx.inc
  writeTasks(tasks)

proc getTaskAll*(): seq[Task] =
  loadTasks()

