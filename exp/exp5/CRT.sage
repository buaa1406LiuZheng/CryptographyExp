# -*- coding: utf-8 -*-
def CRT(b,m,n):
    # x = b[] mod n[] total n equation 
    mod=1                                   #mod是n个模数之基，即答案的模数
    M2=[]                                   #M2储存m中各个Mi模mi的逆,即M'                        
    i=0
    x=0                                     #x为解
    for mi in m:                            #计算mod
        mod*=mi;
    for mi in m:
        Mi=mod//mi
        (null,m2,null)=Euclid(Mi,mi)        #运用扩展欧几里得算法求逆
        M2.append(m2%mi)
    while(i<n):                             #计算x，即每一个b[i]*M[i]*M[i]'的和
        Mi=mod//m[i]
        x=(x+b[i]*Mi*M2[i])%mod
        i=i+1
    return (x,mod)
