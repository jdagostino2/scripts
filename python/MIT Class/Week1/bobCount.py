s = 'bobobob'
start = 0
end = 3
count = 0

for char in s:
    test = s[start:end]
    if test == "bob":
        count += 1
    start += 1
    end += 1
print('Number of times bob occurs is: ' + str(count))
