println("Hello World")

val x = 1
val y = 1.3
val z = "hello"

val q:Integer = 1

val multiline = """test test
test test"""

println(x, y, z, q, multiline)

var a = 2

println(a)

val b = 3
val c = {
  a += 1
  a += b
  a
}

println(c, a)

val d = { 1 > 0 }

val e = if (d)
          1
        else
          2

var f = a
a = 4

var g = {
  var h = 1
  h
}

var h = 4

println(h)
println(g)

def first(a: Integer, b: Integer): Integer = {
  if (b <= 1) {
    return a;
  }

  return a + first(a, b - 1)
}

println("Result" + first(2, 3))
