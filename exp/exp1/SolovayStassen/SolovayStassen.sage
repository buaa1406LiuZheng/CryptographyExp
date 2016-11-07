# -*- coding: utf-8 -*-

import random

def Jacobi(b,n):        #计算b/n雅克比符号
    b=b%n               #b可先变为模n最小非负剩余
    if(b==0):           #n整除b，雅克比符号为0
        return 0        
    elif(b%2==0):       #b为2的倍数,Jacobi(b,n)=Jacobi(2,n)*Jacobi(b/2.n)           
        return ((-1)**((n**2-1)//8))*Jacobi(b//2,n)
    elif(b==1):         #Jacobi(1,n)=1
        return 1
    elif(b==n-1):       #Jacobi(-1,n)=(-1)^((n-1)/2)
        return (-1)**((n-1)//2)
    else:               #利用二次互反律递归调用
        return (-1)**((b-1)//2*(n-1)//2)*Jacobi(n,b)
def modpow(b,n,m):      #模重复平方算法计算b^n(mod m)
    a=1
    while(n!=0):
        r=n%2
        if(r==1):
            a=(a*b)%m
        b=(b*b)%m
        n=n//2
    return a
def ss(n):              #Solovay-Stassen素性检验   
    t=0
    while(t<40):        #安全参数t=40
        t=t+1
        b=random.randint(2,n-1)     #随机选取2<=b<n-1
        x=modpow(b,(n-1)//2,n)      #计算b^((n-1)/2) (mod n)
        if(x==n-1):                 #x=n-1=-1 (mod n)
            x=-1
        y=Jacobi(b,n)               #计算y=Jacobi(b,n)
        if(x!=y or y==0):
            fout.write("no\n")      #根据Solovay-Stassen素性检验法，若x!=y，n为合数
            return
    fout.write("yes\n")             #通过检验，n为（伪）素数
    return


#fin=open("input.txt","r")
#fout=open("output.txt","w")
#count=0
#for line in fin:
#    if(count<5):        #计算前五行的雅克比符号
#        count=count+1
#        num=line.split()
#        fout.write(str(Jacobi(int(num[0]),int(num[1])))+'\n')
#    else:               #检验后五行的数是否为素数
#        ss(int(line))
#fin.close()
#fout.close()

fout=open("output.txt","w")
num = int(input("input a num:\n"))
ss(num)
fout.close()