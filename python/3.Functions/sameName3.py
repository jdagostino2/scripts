# Showing use of the 'global' statement.
def spam():
    global eggs
    eggs = 'spam' # This is global

def bacon():
    eggs = 'bacon' # this is local

def ham():
    print(eggs) # this is global

eggs = 42 # this is global
spam()
print(eggs)