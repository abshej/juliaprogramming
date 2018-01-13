#notes on multiple dispatch

#list of existing methods of any function

#display(methods(+))

# use @which to get what method is being used

println(@which 3 + 3)

#extending methods

import Base: +
try
    "hello" + " world!"
catch e
    println("not possible")
end

+(x::String, y::String) = string(x, y)

println("hello" + " world!")

println(@which "hello" + "World")


##

foo(x, y) = println("duck-typed foo!")
foo(x::Int, y::Float64) = println("foo int and float")
foo(x::Float64, y::Float64) = println(" foo with two floats")

foo(true, false)
foo(1, 2) 
foo(1.0, 2)
foo(1.0, 1.0)
foo(1, 4.456)


