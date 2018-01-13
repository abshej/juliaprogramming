#notes on conditionals

#if elseif else end
#a ? b : c

a = 10

if a < 10
    println("<")
elseif a > 10
    println(">")
else
    println("=")
end

##

if 3 > 2
    x = 3
else
    x = 2
end

#is equal to

x = (3 > 2) ? 3 : 2

println(x)

##

#a && b
#a || b

(3 > 2) && println("3 is > 2")
(3 < 2) && println("Dont print this for the sake of math!")



