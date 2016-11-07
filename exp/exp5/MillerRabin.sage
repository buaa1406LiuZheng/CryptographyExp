# -*- coding: utf-8 -*-

load modpow.sage
import random

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