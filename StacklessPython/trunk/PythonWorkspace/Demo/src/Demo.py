import stackless

def print_x(x):
    print(x)

stackless.tasklet(print_x)("one")
stackless.tasklet(print_x)("two")
stackless.tasklet(print_x)("three")

stackless.run()