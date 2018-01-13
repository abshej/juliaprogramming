#notes on tuples in julia

#tuples are "immutable" ordered lists
randomTuple = ("Avadhoot", "Bhaskar", "Shejwalkar", "Male")

#tuples are immutable
try
    randomTuple[1] = "Nivedita"
catch e
    println(e)
end

#printing
for i in randomTuple
    println(i)
end
