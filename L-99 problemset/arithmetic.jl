# arithmetic secton of 
# http://www.ic.unicamp.br/~meidanis/courses/mc336/2006s2/funcional/L-99_Ninety-Nine_Lisp_Problems.html

function isPrime(N::Int)
# find if a number is prime
	a::Array{Int,1} = [N%i for i in 2:N-1]
	if any(iszero, a)
		false
	else
		true
	end
end

function isPrime2(N::Int)
	if contains(==, rem.(N, 2:N-1), 0)
		return false
	else return true
	end
end


function allDivisors(N::Int)
	# find all divisors of N
	divisors = Set([ N%i==0?i:1 for i in 2:N ])
end

function allDivisorsUsingFor(N::Int)
	# find all divisors of N
	divisors::Set{Int} = Set()
	for i in 1:N
		if N%i==0
			push!(divisors, i)
		end
	end
	divisors
end
 
function greatestCommonDivisor(N1::Int, N2::Int)
# find GCD of two numbers, not using euclidean algorith because this seems functionally faster
	maximum([intersect(allDivisorsUsingFor(N1), allDivisorsUsingFor(N2))...])
end

#find whether a pair is coprime or not
isCoprime(pair::Tuple{Int, Int}) = 1==maximum([intersect(allDivisorsUsingFor(pair[1]), allDivisorsUsingFor(pair[2]))...])

function totient(N::Int)
# Euler's so-called totient function phi(m) is defined as the number of positive integers r (1 <= r < m) that are coprime to m.
	count::Int = 0
	for i in 1:N-1
		if isCoprime((N, i))
			count+=1
		end
	end
	count
end

function primeNumbers(range::UnitRange)
# find primes in a given range
	primes::AbstractArray = []
	for i in range
		if isPrime(i)
			push!(primes, i)
		end
	end
	tuple(primes...)
end

function getGoldbach(N::Int)
# verify goldbach conjecture for given N
	goldbachSet = Nullable{Tuple{Int, Int, Int}}()
	if iseven(N) && N>2
		primes = primeNumbers(2:N)
		for i in primes, j in primes
			if i+j==N
				goldbachSet = (i, j, N)
			end
		end			
	else
		# for odd numbers and first three natural numbers
		return false #or goldbachSet which is also Nullable
	end
	goldbachSet
end

#list Goldbach compositions for all numbers in a range
listGoldbach(range::UnitRange) = tuple([getGoldbach(i) for i in range]...)


