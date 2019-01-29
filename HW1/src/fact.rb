#! /usr/bin/env ruby

def fact(n)
  return 1 if n == 0
  return n * fact(n-1)
end

if ARGV.length != 1 
  puts "fact.rb usage: [NUMBER]" 
  exit
end

puts fact(ARGV[0].to_i)
