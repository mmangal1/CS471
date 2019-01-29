#Maitri Mangal
#CS471 Assignment 1

#! /usr/bin/env ruby

def gcdI(i, j)
	while i != j
		if i > j
			i = i - j
		else
			j = j - i
		end
	end
	return i
end

def gcdF(i, j)
	return gcdF(i-j, j) if i > j
	return i if i == j
	return gcdF(i, j-i)
end 

if ARGV.length != 2 
  puts "gcd_full.rb usage: [NUMBER] [NUMBER]" 
  exit
end

puts "gcdI() : " + gcdI(ARGV[0].to_i, ARGV[1].to_i).to_s
puts "gcdF() : " + gcdF(ARGV[0].to_i, ARGV[1].to_i).to_s
