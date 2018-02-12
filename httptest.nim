import httpclient,ospaths

try:
  let c = newHttpClient( )#userAgent = "NIM It" )
  echo c.getContent(getEnv("TEST_URL"))

except ProtocolError:
  let e = getCurrentException()
  echo e.msg
  raise e

# used for debugging
if false:
  try:
    let c = newHttpClient( maxRedirects = 10, userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:59.0) Gecko/20100101 Firefox/59.0 NIM" )
    let v =  c.getContent(getEnv("TEST_URL"))
    echo v

  except ProtocolError:
    let e = getCurrentException()
    echo e.msg
    raise e