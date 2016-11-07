import time
def Fibonacci(n):
    a=1
    b=1
    i=1
    while(i<n):
        a=a+b
        b=a-b
        i=i+1
    return a,b

i=100000
while(i<=1000000):
    start=time.process_time()
    a,b=Fibonacci(i)
    over=time.process_time()
    print(over-start)
    i+=100000
