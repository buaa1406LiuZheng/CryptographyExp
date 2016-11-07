# -*- coding: utf-8 -*-

def mod_pow(b,n,m):
    if(n==1):
        return (b%m)
    a=mod_pow(b,n//2,m)
    if(n%2==0):
        return ((a*a)%m)
    else:
        return ((a*a*b)%m)

b=int(input("b:"))
while(True):    
    n=int(input("n:"))
    if(n>=0):
        break
    print("please input a non-negative integer")
m=int(input("m:"))
a=mod_pow(b,n,m)
print(a)
