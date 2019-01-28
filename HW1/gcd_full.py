#! /usr/bin/env python
import sys

def gcdI(i, j):
	while i != j:
		if i > j:
			i = i - j
		else:
			j = j - i
	return i

def gcdR(i, j):
	if i > j : return gcdR(i-j, j)
	elif i == j : return i
	else : return gcdR(i, j-i)


if len(sys.argv) != 3:
  print("%s usage: [NUMBER] [NUMBER]" % sys.argv[0])
  exit()

print("gcdI() : "+ str( gcdI(int(sys.argv[1]), int(sys.argv[2]))))
print("gcdR() : "+ str( gcdR(int(sys.argv[1]), int(sys.argv[2]))))
