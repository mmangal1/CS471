#Maitri Mangal
#CS471 Assignment 1

#! /usr/bin/env python

import sys

def fact(n):
  if n == 0:
    return 1
  else:
    return n * fact(n-1)

if len(sys.argv) != 2:
  print("%s usage: [NUMBER]" % sys.argv[0])
  exit()

print(fact(int(sys.argv[1])))
