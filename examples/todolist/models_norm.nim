import norm/[model, sqlite]

const DBName = "todo.db"

type
  Task* = ref object of Model
    task*: string

func newTask*(task: string = ""): Task =
  Task(task: task)

template modelProc*(dbconn: untyped, statments: untyped): untyped =
  var dbconn = open(DBName, "", "", "")
  defer:
    dbconn.close()
  statments

proc initModel*() =
  modelProc(db):
    db.createTables(newTask())

proc getTaskAll*(): seq[Task] =
  result = @[newTask()]
  modelProc(db):
    db.selectAll(result)

proc addTask*(taskText: string) =
  var task = newTask(taskText)
  modelProc(db):
    db.insert(task)

proc delTask*(taskId: int) =
  var task = newTask()
  modelProc(db):
    db.select(task, "id = ?", taskId)
    db.delete(task)
