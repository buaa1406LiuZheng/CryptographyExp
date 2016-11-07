# -*- coding: utf-8 -*-

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
    return s[i]

def CRT(b,m,n):
    mod=1                                   #mod是n个模数之基，即答案的模数
    M2=[]                                   #M2储存m中各个Mi模mi的逆,即M'                        
    i=0
    x=0                                     #x为解
    for mi in m:                            #计算mod
        mod*=mi;
    for mi in m:
        Mi=mod//mi
        m2=Euclid(Mi,mi)                    #运用扩展欧几里得算法求逆
        M2.append(m2%mi)
    while(i<n):                             #计算x，即每一个b[i]*M[i]*M[i]'的和
        Mi=mod//m[i]
        x=(x+b[i]*Mi*M2[i])%mod
        i=i+1
    return (x,mod)


fin=open("input.txt",'r')
b=[]                                        #B储存余数
m=[]                                        #M储存模数

n=int(fin.readline())                       #输入
i=0;
while(i<n):                                 
    line=fin.readline()
    num=line.split()
    b.append(int(num[0]))
    m.append(int(num[1]))
    i=i+1

(x,mod)=CRT(b,m,n)
print(str(x)+' '+str(mod))

fin.close()
