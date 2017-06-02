s = 'clmxlsnciulatyzwm'
# clmx
a = ''
b = ''
for char in s:
    if (b == ''):
        b = char
        #print('B set to: ' + b)
    elif (b[-1] <= char):
        b += char
        #print('B +=: ' + b)
    elif (b[-1] > char):
        if (len(a) < len(b)):
            a = b
            b = char
            #print('A: ' + a + ' B: ' + b)
        else:
            b = char
            #print('Else B: ' + b)
if (len(b) > len(a)):
    a = b
    #print('B > A: ' + a)
print('Longest substring in alphabetical order is: ' + a)
