#notes on functions

function name(args...)
    for i in args 
        println(i)
    end
end

name(1,2,3,4,5)

#short declaration

add(x, y) = x + y

println(add(2, 3))

#

sub = x -> println(x)

sub(3)

#  

function opt(name = "thisisgenericname")
    println(opt)
end

opt("thisisnametoo")
opt()

function keyw(x ;a = 12, b = 3)
    println("a is $a and b is $b")
end
keyw(3, a = 10)

## 
a = rand(10)
display(a) 
display(sort(a))
display(a)
sort!(a)
display(a)


#broadcasting
#f.(a)

function sqr(a) 
    a^2
end

b = [1,2,3,4,5,6,7]
try
    display(sqr(b))
catch e
    println("nope")
end

display(sqr.(b))



