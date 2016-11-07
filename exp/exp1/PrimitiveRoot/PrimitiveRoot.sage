# -*- coding: utf-8 -*-

import random
import time

def gdc(a,b):
    while(b!=0):
        r=a%b
        a=b
        b=r
    return a
def modpow(b,n,m):          #模重复平方算法计算b^n(mod m)
    a=1
    while(n!=0):
        r=n%2
        if(r==1):
            a=(a*b)%m
        b=(b*b)%m
        n=n//2
    return a
def mr(n):
    s=0
    t=n-1
    while(t%2==0):          #计算s,t使n-1=(2^s)*t
        s=s+1
        t=t//2
    k=0
    while(k<40):            #安全参数为40，每次循环为一次检验
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
            return 0        #本次检验不通过，根据Miller-Rabin素性检验法，n为合数
        k=k+1
    return 1                #通过整个检验，n为（伪）素数

fout=open("output.txt",'w')

while(1):                   #生成一个能通过mr素性检验的数n
    n=random.randrange(2**16+1,2**17,2)
    if(mr(n)):
        break

n=33073
start=time.time()
fout.write(str(n)+'\n原根:\n')

for i in range(2,n):        #找一个n的原根
    k=i
    for j in range (2,(n-1)//2+2):      #检验到j==(n-1)//2若还没有k==1，j=j+1=(n-1)//2+1,此时判定i为原根
        k=(k*i)%n
        if(k==1):
            break
    if(j==(n-1)//2+1):      #如果i^m(mod n) 1<m<=(n-1)/2均不为1，则i是n的一个原根
        MinPRoot=i          #因为是从小往大找，所有找到的第一个就是最小的原根
        break

count=1
k=MinPRoot
PRoot=[k]
for i in range(2,n):
    k=(k*MinPRoot)%n
    if(gdc(i,n-1)==1):      #根据定理，如果gdc(d,phi(n))=1,g为原根，则g^d为原根
        PRoot.append(k)
        count+=1

PRoot=sorted(PRoot)         #将原根的数组排序
for i in range(0,min(10,count)):       #输出最小的10个原根（不足10个全部输出）
    fout.write(str(PRoot[i])+'\n')

fout.write("原根的数量是："+str(count)+'\n')
fout.write(str(MinPRoot)+"在模"+str(n)+"下的离散对数表为:\n")
PRootPow=1
for i in range(1,n):        #输出最小原根的离散对数表
    PRootPow=(PRootPow*MinPRoot)%n
    fout.write(str(i)+':'+str(PRootPow)+'\n')

end=time.time()

runtime=end-start

fout.write("运行时间："+str(runtime)+'s')

fout.close()
