def mod_pow(b,n,m):
    a=1
    while(n!=0):
        r=n%2
        if(r==1):
            a=(a*b)%m
        b=(b*b)%m
        n=n//2
    return a

b=int(input("b:"))
while(True):    
    n=int(input("n:"))
    if(n>=0):
        break
    print("please input a non-negative integer")
m=int(input("m:"))
a=mod_pow(b,n,m)
print(a)
