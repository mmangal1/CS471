#!/usr/bin/ruby
# 

def foo(x)
#	y = 2

# Proc
# Proc objects are blocks of code that have been bound to a set of local variables. 
# Once bound, the code may be called in different contexts and still access those variables.
# http://www.ruby-doc.org/core-2.1.3/Proc.html


	bar = Proc.new {
		print x, "\n"
		y = 99
	}
	bar.call()
	print y, "\n"
end

foo(3)
