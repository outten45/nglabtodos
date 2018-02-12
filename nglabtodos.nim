import ospaths,strutils,httpclient,json,tables

type
  Author = object
    username: string

  Todo = object
    id: int
    author: Author
    target_type: string
    body: string
    state: string
    created_at: string
    target_url: string

proc url(): string =
  result = "$1$2todos" % [getEnv("GLAB_HOST"), getEnv("GLAB_APIPATH")]

proc token(): string =
  result = getEnv("GLAB_TOKEN")

proc checkTodos(): Response =
  var client = newHttpClient()
  client.headers = newHttpHeaders({ "PRIVATE-TOKEN": token() })
  let response = client.request(url(), httpMethod = HttpGet)
  client.close
  return response

proc createText(todo: Todo): string =
   return "[$1]($4) from $2 ($3) " % [todo.body, todo.author.username, todo.state, todo.target_url]

proc sendToMattermost(username: string, text: string): bool =
  result = false
  let body = %*
    {
      "username": username,
      "text": text
    }
  if existsEnv("MM_WEBHOOK"):
    var client = newHttpClient()
    let response = client.request(getEnv("MM_WEBHOOK"), httpMethod = HttpPost, body = $body)
    client.close
    if response.status != "200":
      result = true

proc sendTodos(todos: JsonNode) =
  for i in json.items(todos):
    let todo = to(i, Todo)
    let msg = createText(todo)
    let res = sendToMattermost("nim", msg)
    if not res:
      echo "Unable to send message to mattermost - $#" % [msg]

proc main() =
  let res = checkTodos()
  let todos = parseJson(res.body)
  sendTodos(todos)

main()


