# -*- coding: utf-8 -*-

import random
import time

def gdc(a,b):                   #计算a,b的最大公因数
    while(b!=0):
        r=a%b
        a=b
        b=r
    return a
def modpow(b,n,m):              #利用模重复平方算法计算b^n(mod m)
    a=1
    while(n!=0):
        r=n%2                   #这一步与n=n//2即把n拆成一个二进制数
        if(r==1):
            a=(a*b)%m           
        b=(b*b)%m               #模的平方
        n=n//2
    return a
def fermattest(n):              #Fermat素性检验
    start=time.time()
    i=0
    while(i<10):                #随机生成10个基b对n进行检验
        b=random.randrange(1,n)
        if(gdc(n,b)!=1):        #最大公因数不为1则不是素数
            fout.write("NO %.4fms\n"%((time.time()-start)*1000))
            return
        elif(modpow(b,n-1,n)!=1):   #利用Fermat定理,b^(n-1)(mod n)不等于1,n不是素数
            fout.write("NO %.4fms\n"%((time.time()-start)*1000))
            return
        i=i+1
    fout.write("YES %.4fms\n"%((time.time()-start)*1000))     #检验完毕，n是素数
    return
def isprime(n):                 #暴力算法进行检验
    start=time.time()
    i=3
    while(i*i<=n):
        if(n%i==0):
            fout.write("NO %.4fms/\n"%((time.time()-start)*1000))
            return
        i=i+2
    fout.write("YES %.4fms/\n"%((time.time()-start)*1000))
    return

fin=open("input.txt","r")
fout=open("output.txt","w")
for i in fin:
    n=int(i)                    #从input中读取数据转化为一个整数
    fermattest(n)               #用Fermat素性检验进行检验
    #isprime(n)                 #暴力检验
fermattest(2**7025-1)
fin.close()
fout.close()
