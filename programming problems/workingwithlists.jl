# Problem set taken from:
# http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html
# built-in functions are used as required because this exercise was done to get familiar with the language

# get last element of a list
lastBox(list::Tuple) = list[end]

# get last two elements of a list
lastButOne(list::Tuple) = list[end-1:end]

# get element from a list at a specific index
elementAt(list::Tuple, index::Int) = try list[index] catch e println(e) end

# count total no. of elements in a list
totalElements(list::Tuple) = length(list)

# return a reversed list
reverseElements(list::Tuple) = reverse!(list)

# check if a list is palindromic
isPalindrome(list::Tuple) = (list==reverse(list)?true:false)

function flattenList(list::Tuple)
#= Takes a list consisting of lists and makes a flat list of all elements of individual internal lists grouped together =#
# using recursion
	flattened::AbstractArray = []
	for i in list
		if i isa Tuple
			temp = flattenList(i)
			for j in temp
				push!(flattened, j)
			end
		else
			push!(flattened, i)
		end
	end
	tuple(flattened...)
end

function eliminateConsecutiveDuplicates(list::Tuple)
# represent consecutive similar list elements with once in a list
	outputList::AbstractArray = [list[1]]
	for i in 2:1:length(list)
  		if list[i]!=list[i-1]
			push!(outputList, list[i])
		end
	end
	tuple(outputList...)
end

function packConsecutiveDuplicates(list::Tuple)
# pack consecutive similar list elements into separate lists
	#tic()
	outputList::AbstractArray = []
	miniList::AbstractArray = [list[1]]
	for i in 2:length(list)
		if list[i]==list[i-1]
			push!(miniList, list[i])
			if i==length(list)
				push!(outputList, tuple(miniList...))
			end
		else
			push!(outputList, tuple(miniList...))
			miniList = [list[i]]
			if i==length(list)
				push!(outputList, tuple(miniList...))
			end
		end
	end
	#toc()
	tuple(outputList...)
end

function rlencoding(stream::String)
# Run-length encoding (RLE) is a simple form of data compression, where runs (consecutive data elements) are replaced by just one data value and count.
	stream = stream * " "
	encodedStream = ""
	tempChar = ' '
	tempCount = 0
	for i in stream[1:end]
		if tempChar==i
			tempCount+=1
		elseif tempCount>1
			encodedStream = string(encodedStream, string(tempCount))
			encodedStream = string(encodedStream, string(tempChar))
			tempChar=i
			tempCount=1
		else
			encodedStream = string(encodedStream, string(tempChar))
			tempChar=i
			tempCount=1
		end
	end
	uppercase(encodedStream)
end

function rldecoding(rlEncodedStream::String)
# decode the stream encoded by rlencoding
	decodedStream = ""
	tempCount = 1
	tempChar = ' '
	for i in rlEncodedStream
		if isnumber(i)
			tempCount = parse(Int, i)
			x=false
		else
			tempChar = i
			x=true
		end
		if x==true
			decodedStream = decodedStream * string(string(tempChar)^tempCount)
			tempCount=1
		end
	end
	uppercase(decodedStream)
end	

function duplicateListElements(list::Tuple)
# add twice the no. of each elements in the list in the given order
#= (a a b d) => (a a a a b b d d) =#
	outputList::AbstractArray = []
	packedElements = packConsecutiveDuplicates(list) # function defined above
	for i in packedElements, j in 1:2
		push!(outputList, tuple(i))
	end
	flattenList(flattenList(tuple(outputList...))) # function defined above
end

function replicateListElements(list::Tuple, counter::Int)
# add counter times the no. of each elements in the list in the given order
#= (a a b d) => (a a a a b b d d) =#
	outputList::AbstractArray = []
	packedElements = packConsecutiveDuplicates(list) # function defined above
	for i in packedElements, j in 1:counter
		push!(outputList, tuple(i))
	end
	flattenList(flattenList(tuple(outputList...))) # function defined above
end

function dropEveryNth(list::Tuple, N::Int)
# drop every Nth item from the list
	@show outputList::AbstractArray = [list...]
	for i in N:(N-1):length(outputList)
		try # saves lives
			splice!(outputList, i)
		catch e
		end
		#push!(outputList, 0) needed if try and catch are not used
	end
	tuple(outputList...)
end

# split given list into two lists based on the split index
splitIntoTwo(list::Tuple, splitIndex::Int) = list[1:splitIndex], list[splitIndex+1:end]

# get a slice from a list; 3-5 in (1,2,3,4,5,6,7,8) is (3,4,5); takes a unit range
slicedList(list::Tuple, sliceRange::UnitRange) = try list[sliceRange] catch e println("Wrong Range") end
slicedList(list::Tuple, start::Int, ends::Int) = try list[start:ends] catch e println("Wrong Range") end

# rotate a list N places to the left
lrotateNPlaces(list::Tuple, N::Int) = flattenList(tuple(list[N+1:end], list[1:N]))

# remove Kth element from a TUPLE list
function removeKthElement(list::Tuple, K::Int)
	tempList::AbstractArray = []
	for i in list
		if i!=K
			push!(tempList, i)
		end
	end
	tuple(tempList...)
end

# insert an element into a given list using at given index; using array because tuples are immutable
insertElement!(list::AbstractArray, index::Int, item::Any) = insert!(list, index, item)
#another tuple can be returned though
insertElement!(list::Tuple, index::Int, item::Any) = tuple(insert!([list...], index, item)...)

# create list of integers containing all elements in a given range
createListUsingRange(range::UnitRange) = tuple(range...)

# extract given no. of randomly selected elements from list
function extractRandomElements(list::Union{Tuple, AbstractArray}, N::Int)
	indices::Set{Int} = Set()
	extractedItems::AbstractArray{} = []
	i::Int = 1
	if N<=length(list)
		while i<=N
			randomIndex = rand(1:length(list))
			if !contains(==, indices, randomIndex)
				push!(indices, randomIndex)
				push!(extractedItems, list[randomIndex])
				i+=1
			end
		end
		tuple(extractedItems...)
	else
		println("No of elements to be extracted greater than length of list.")
	end
end

# draw N randomly selected items from a given range
function extractRandomElementsFromRange(range::UnitRange, N::Int)
	extractedItems::AbstractArray{} = []
	i::Int = 1
	if N<=length(range)
		while i<=N
			randomItem = rand(range)
			if !contains(==, extractedItems, randomItem)
				push!(extractedItems, randomItem)
				i+=1
			end
		end
		tuple(extractedItems...)
	else
		println("No of elements to extracted greater than size of range.")
	end
end

# generate random permutation of elements of a list
# (1 2 3 4 5 6) => (3 1 6 2 5 4) random permutation every time
generateRandomPermutationOfList(list::Union{Tuple, AbstractArray}) = extractRandomElements(list, length(list))

# generate combinations of K distinct objects chosen from the elements of list
function generateCombinationsFromList(list::Union{Tuple, AbstractArray}, K::Int)
	combinations::AbstractArray = []
	generated = extractRandomElements(list, K)
	i::Int = 1
	if K!=length(list)
		while i<binomial(length(list), K) #binomial(n,k) gives no. of ways to choose k out of n items
			if !contains(==, combinations, generated)
				push!(combinations, generated)
				i+=1
			end
			generated = extractRandomElements(list, K)
		end
	else
		while i<=factorial(length(list))
			if !contains(==, combinations, generated)
				push!(combinations, generated)
				i+=1
			end
			generated = extractRandomElements(list, K)
		end
	end
	tuple(combinations...)
end

# input = (aldo beat carla david evi flip gary hugo ida), (2 2 5)
# output = ( ( (ALDO BEAT) (CARLA DAVID) (EVI FLIP GARY HUGO IDA) )... )
function generateDisjointGroups(list::Union{Tuple, AbstractArray}, groups::AbstractArray{Int, 1})
	combinationsHolder::AbstractArray = [generateCombinationsFromList(list, length(list))...]
	outputList::AbstractArray = []
	if sum(groups)!=length(list)
		push!(groups, (length(list)-sum(groups)))
		print_with_color(:red, groups)
		println()
	end
	for combination in combinationsHolder
		combination = [combination...]
		tempHolder::AbstractArray = []
		for i in groups
			push!(tempHolder, combination[1:i])
			splice!(combination, 1:i)
		end
		push!(outputList, tempHolder)
	end
	tuple(outputList...)
end

# sort list of lists according to the length of sublists
function sortAccordingToSublistsLength(list::Union{Tuple, AbstractArray})
	outputList::AbstractArray = []
	dict = Dict()
	for i in list
		dict[length(i)] = i
	end
	for i in sort!([keys(dict)...])
		push!(outputList, dict[i])
	end
	tuple(outputList...)
end	
