# -*- coding: utf-8 -*-
# This file was *autogenerated* from the file PrimitiveRoot.sage
from sage.all_cmdline import *   # import sage library
_sage_const_40 = Integer(40); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_10 = Integer(10); _sage_const_17 = Integer(17); _sage_const_16 = Integer(16); _sage_const_33073 = Integer(33073)
import random
import time

def gdc(a,b):
    while(b!=_sage_const_0 ):
        r=a%b
        a=b
        b=r
    return a
def modpow(b,n,m):          #模重复平方算法计算b^n(mod m)
    a=_sage_const_1 
    while(n!=_sage_const_0 ):
        r=n%_sage_const_2 
        if(r==_sage_const_1 ):
            a=(a*b)%m
        b=(b*b)%m
        n=n//_sage_const_2 
    return a
def mr(n):
    s=_sage_const_0 
    t=n-_sage_const_1 
    while(t%_sage_const_2 ==_sage_const_0 ):          #计算s,t使n-1=(2^s)*t
        s=s+_sage_const_1 
        t=t//_sage_const_2 
    k=_sage_const_0 
    while(k<_sage_const_40 ):            #安全参数为40，每次循环为一次检验
        b=random.randint(_sage_const_2 ,n-_sage_const_1 )     #随机选取2<=b<n-1
        r=modpow(b,t,n)     #计算r=b^t (mod n)
        if(r==_sage_const_1 ):
            continue        #r==1，通过本次检验
        i=_sage_const_0 
        while(i<s):         #r=b^((2^i)*t)
            if(r==n-_sage_const_1 ):     #r==-1 (mod n) 通过本次检验
                break
            r=(r**_sage_const_2 )%n
            i=i+_sage_const_1 
        if(i==s):
            return _sage_const_0         #本次检验不通过，根据Miller-Rabin素性检验法，n为合数
        k=k+_sage_const_1 
    return _sage_const_1                 #通过整个检验，n为（伪）素数

fout=open("output.txt",'w')

while(_sage_const_1 ):                   #生成一个能通过mr素性检验的数n
    n=random.randrange(_sage_const_2 **_sage_const_16 +_sage_const_1 ,_sage_const_2 **_sage_const_17 ,_sage_const_2 )
    if(mr(n)):
        break

n=_sage_const_33073 
start=time.time()
fout.write(str(n)+'\n原根:\n')

for i in range(_sage_const_2 ,n):        #找一个n的原根
    k=i
    for j in range (_sage_const_2 ,(n-_sage_const_1 )//_sage_const_2 +_sage_const_2 ):      #检验到j==(n-1)//2若还没有k==1，j=j+1=(n-1)//2+1,此时判定i为原根
        k=(k*i)%n
        if(k==_sage_const_1 ):
            break
    if(j==(n-_sage_const_1 )//_sage_const_2 +_sage_const_1 ):      #如果i^m(mod n) 1<m<=(n-1)/2均不为1，则i是n的一个原根
        MinPRoot=i          #因为是从小往大找，所有找到的第一个就是最小的原根
        break

count=_sage_const_1 
k=MinPRoot
PRoot=[k]
for i in range(_sage_const_2 ,n):
    k=(k*MinPRoot)%n
    if(gdc(i,n-_sage_const_1 )==_sage_const_1 ):      #根据定理，如果gdc(d,phi(n))=1,g为原根，则g^d为原根
        PRoot.append(k)
        count+=_sage_const_1 

PRoot=sorted(PRoot)         #将原根的数组排序
for i in range(_sage_const_0 ,min(_sage_const_10 ,count)):       #输出最小的10个原根（不足10个全部输出）
    fout.write(str(PRoot[i])+'\n')

fout.write("原根的数量是："+str(count)+'\n')
fout.write(str(MinPRoot)+"在模"+str(n)+"下的离散对数表为:\n")
PRootPow=_sage_const_1 
for i in range(_sage_const_1 ,n):        #输出最小原根的离散对数表
    PRootPow=(PRootPow*MinPRoot)%n
    fout.write(str(i)+':'+str(PRootPow)+'\n')

end=time.time()

runtime=end-start

fout.write("运行时间："+str(runtime)+'s')

fout.close()