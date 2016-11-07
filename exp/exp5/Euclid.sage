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
    return a,s[i],t[i]