import httpclient,ospaths

try:
  let c = newHttpClient( )#userAgent = "NIM It" )
  echo c.getContent(getEnv("TEST_URL"))

except ProtocolError:
  let e = getCurrentException()
  echo e.msg
  raise e