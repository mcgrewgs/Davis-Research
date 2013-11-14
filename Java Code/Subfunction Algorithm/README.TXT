42386176 bent functions in 6 variables, of which 388864 are pure quadratic.

Given cubic terms, you can get either 36864 or 64512 combinations that work.
Solve[ 36864*x + 64512*y == 42386176 - 388864 && x + y == 1023, {x,y} ] gives x = 868 = 28*31, y = 155 = 5*31

Given a first half (any first half), there are exactly 192 = 12*16 possible second halves.