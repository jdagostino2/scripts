# Showing that you can not use a local scope in another function.

def spam():
    eggs = 99
    bacon()
    print(eggs)

def bacon():
    ham = 101
    eggs =0

spam()
