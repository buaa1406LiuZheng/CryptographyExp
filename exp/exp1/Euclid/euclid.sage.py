# -*- coding: utf-8 -*-
# This file was *autogenerated* from the file /Users/liuzheng/Public/sageFile/实验一/Euclid/euclid.sage
from sage.all_cmdline import *   # import sage library
_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_1000 = Integer(1000)
import time

def Euclid(a,b):	
    r=b                 #r是余数
    s=[_sage_const_1 ,_sage_const_0 ,_sage_const_0 ]         
    t=[_sage_const_0 ,_sage_const_1 ,_sage_const_0 ]           #储存s和t,r[j]=a*s[j]+b*t[j],其中r[-2]=a,r[-1]=b
    i=_sage_const_0 				  
    while(r!=_sage_const_0 ):
        q=a//b
        r=a%b
        a=b
        b=r                                 #计算余数r,商q以及对下一步的欧几里得除法赋值
        s[(i+_sage_const_2 )%_sage_const_3 ]=s[i]-q*s[(i+_sage_const_1 )%_sage_const_3 ]        #s[i+2]=s[i]-q*s[i+1]
        t[(i+_sage_const_2 )%_sage_const_3 ]=t[i]-q*t[(i+_sage_const_1 )%_sage_const_3 ]        #t[i+2]=t[i]-q*t[i+1]
        i=(i+_sage_const_1 )%_sage_const_3                            #s,t是循环队列，下标i对3取模
    return a,s[i],t[i]

a=int(input("a:"))
b=int(input("b:"))		#输入

start=time.time()	#开始计时
gdc,s,t=Euclid(a,b)		#计算最大公因数gdc和s、t
if(gdc<_sage_const_0 ):
    gdc=-gdc
    s=-s
    t=-t			#当b为负数时，gdc为负数；此处把gdc调整为正值
end=time.time()		#停止计时

print("gdc:%d s:%d t:%d"%(gdc,s,t,))
print("%.4fms"%((end-start)*_sage_const_1000 ))
