# -*- coding: utf-8 -*-
# This file was *autogenerated* from the file SolovayStassen.sage
from sage.all_cmdline import *   # import sage library
_sage_const_40 = Integer(40); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_8 = Integer(8)
import random

def Jacobi(b,n):        #计算b/n雅克比符号
    b=b%n               #b可先变为模n最小非负剩余
    if(b==_sage_const_0 ):           #n整除b，雅克比符号为0
        return _sage_const_0         
    elif(b%_sage_const_2 ==_sage_const_0 ):       #b为2的倍数,Jacobi(b,n)=Jacobi(2,n)*Jacobi(b/2.n)           
        return ((-_sage_const_1 )**((n**_sage_const_2 -_sage_const_1 )//_sage_const_8 ))*Jacobi(b//_sage_const_2 ,n)
    elif(b==_sage_const_1 ):         #Jacobi(1,n)=1
        return _sage_const_1 
    elif(b==n-_sage_const_1 ):       #Jacobi(-1,n)=(-1)^((n-1)/2)
        return (-_sage_const_1 )**((n-_sage_const_1 )//_sage_const_2 )
    else:               #利用二次互反律递归调用
        return (-_sage_const_1 )**((b-_sage_const_1 )//_sage_const_2 *(n-_sage_const_1 )//_sage_const_2 )*Jacobi(n,b)
def modpow(b,n,m):      #模重复平方算法计算b^n(mod m)
    a=_sage_const_1 
    while(n!=_sage_const_0 ):
        r=n%_sage_const_2 
        if(r==_sage_const_1 ):
            a=(a*b)%m
        b=(b*b)%m
        n=n//_sage_const_2 
    return a
def ss(n):              #Solovay-Stassen素性检验   
    t=_sage_const_0 
    while(t<_sage_const_40 ):        #安全参数t=40
        t=t+_sage_const_1 
        b=random.randint(_sage_const_2 ,n-_sage_const_1 )     #随机选取2<=b<n-1
        x=modpow(b,(n-_sage_const_1 )//_sage_const_2 ,n)      #计算b^((n-1)/2) (mod n)
        if(x==n-_sage_const_1 ):                 #x=n-1=-1 (mod n)
            x=-_sage_const_1 
        y=Jacobi(b,n)               #计算y=Jacobi(b,n)
        if(x!=y or y==_sage_const_0 ):
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
