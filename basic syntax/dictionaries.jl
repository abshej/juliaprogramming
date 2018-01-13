#this are notes about dictionaries in julia 

#dictionaries are not ordered lists
dict = Dict("first"=>"Avadhoot","last"=>"Shejwalkar")

#adding to dictionary
dict["middle"] = "Bhaskar"

#printing
for i in dict
    println("$(i[1]) name is $(i[2])")
end

#dictionaries do not have indexed elements
try
    dict[1]
catch e
    println(e)
end
