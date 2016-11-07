# -*- coding: utf-8 -*-

import random

def getRandomPrime(primeLen = 160):

    maxPrime = 1<<primeLen
    while(True):
        rand = random.randrange(maxPrime//2+1,maxPrime,2)
        if(PrimeTest(rand)):
            break
    return rand

def PrimeTest(n):
    s=0
    t=n-1
    while(t%2==0):          #计算s,t使n-1=(2^s)*t
        s=s+1
        t=t//2
    k=0
    while(k<40):            #安全参数为40，每次循环为一次检验
        k=k+1
        b=random.randint(2,n-1)     #随机选取2<=b<n-1
        r=modpow(b,t,n)     #计算r=b^t (mod n)
        if(r==1):
            continue        #r==1，通过本次检验
        i=0
        while(i<s):         #r=b^((2^i)*t)
            if(r==n-1):     #r==-1 (mod n) 通过本次检验
                break
            r=(r**2)%n
            i=i+1
        if(i==s):
            return False        #本次检验不通过，根据Miller-Rabin素性检验法，n为合数
    return True                 #通过整个检验，n为（伪）素数

def modpow(b,n,m):
    #模重复平方算法计算b^n(mod m)

    if(n<0):
        (gcd,bInverse,t) = Euclid(b,m)
        if(gcd!=1):
            print("n<0 and b have no Inverse")
        else:
            return modpow(bInverse,-n,m)
    else:
        a=1
        while(n!=0):
            r=n%2
            if(r==1):
                a=(a*b)%m
            b=(b*b)%m
            n=n//2
        return a

def Euclid(a,b):    
    r=b                 #r是余数
    s=[1,0,0]         
    t=[0,1,0]           #储存s和t,r[j]=a*s[j]+b*t[j],其中r[-2]=a,r[-1]=b
    i=0               
    while(r!=0):
        q=a//b
        r=a%b
        a=b
        b=r                                 #计算余数r,商q以及对下一步的欧几里得除法赋值
        s[(i+2)%3]=s[i]-q*s[(i+1)%3]        #s[i+2]=s[i]-q*s[i+1]
        t[(i+2)%3]=t[i]-q*t[(i+1)%3]        #t[i+2]=t[i]-q*t[i+1]
        i=(i+1)%3                           #s,t是循环队列，下标i对3取模
    return a,s[i],t[i]