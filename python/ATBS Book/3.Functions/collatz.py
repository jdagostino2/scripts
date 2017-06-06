# Code for the Collatz sequence, will always return 1.

print ('Enter number:')

def collatz(numTry):
    if numTry % 2 == 0:
        global number
        number = number // 2
    else:
        number = 3 * number + 1

try:
    number = int(input())
except ValueError:
    print('That is not a number!')

while number > 1:
    collatz(number)
    print(number)
