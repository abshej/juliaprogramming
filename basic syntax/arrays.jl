#notes on arrays in julia 

#arrays are mutable and ordered
nameArray = ["first", "second"] #String array

randomNumArray = [1, 1, 2, 3, 5, 8] #numerical array

randomArray = ["firststring", pi, 3]

println(typeof(randomArray))

#adding elements
try
    push!(nameArray, 3.14)
catch e
    push!(nameArray, "3.14")
end

unshift!(nameArray, "stringring")

println(nameArray)

#removing elements

pop!(nameArray)
shift!(nameArray)

splice!(nameArray, 2)

println(nameArray)


#multidimensional arrays
multidimArray = [[1,2,3,4],
                 [2,3,4,5],
                 [3,4,5,6]]

println(multidimArray)

#random array creating

println(rand(4, 3))

println(rand(4, 3, 2))


