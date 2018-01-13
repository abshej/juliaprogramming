#notes on looping in julia

#while loop


#while *condition*
#    *loop body*
#end
#

#for loop


#for *var* in *iterable*
#    *loop body*
#end

#

for i in rand(10)
    println(i)
end

for n = 1:10
    println(n)
end

###

m, n = 5, 5
A = zeros(m, n)

for i in 1:m
    for j in 1:n
        A[i, j] = i + j
    end
end

display(A)

##
##double array hatkee
B = zeros(m, n)

for i in 1:m, j in 1:n
    B[i, j] = i + j
end
display(B)


##array comprehensions
C = [i + j for i in 1:m, j in 1:n]
display(C)

##
for n in 1:10
    A = [i + j for i in 1:n, j in 1:n]
    display(A)
end

