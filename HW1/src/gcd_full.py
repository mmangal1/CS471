#Maitri Mangal
#CS471 Assignment 1

#! /usr/bin/env python
import sys

def gcdI(i, j):
	while i != j:
		if i > j:
			i = i - j
		else:
			j = j - i
	return i

#it is called gcdF instead of gcdR in the assignment page
def gcdF(i, j):
	if i > j : return gcdF(i-j, j)
	elif i == j : return i
	else : return gcdF(i, j-i)


if len(sys.argv) != 3:
  print("%s usage: [NUMBER] [NUMBER]" % sys.argv[0])
  exit()

print("gcdI() : "+ str( gcdI(int(sys.argv[1]), int(sys.argv[2]))))
print("gcdF() : "+ str( gcdF(int(sys.argv[1]), int(sys.argv[2]))))
