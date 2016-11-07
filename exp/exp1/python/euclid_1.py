import time
import tracemalloc

def Euclid(a,b):
    r=b             #r是余数
    Q=[]            #储存每一步计算得出的商q用于回代求s,t
    while(r!=0):    #计算最大公因数并求出每一步得出的商
        q=a//b
        r=a%b
        Q.append(q) #储存q
        a=b
        b=r         
    s=1
    t=0             
    n=len(Q)-1      #gdc=r[n-1]，s[n-1]=1 r[n-1]=0，r[-2]=a,r[-1]=b
    while(n>=0):    #逐次回代求得s和t,gdc=r[i-1]*s[i-1]+r[i]*t[i-1]
        temp=s
        s=t
        t=temp-t*Q[n]   #s[i-1]=t[i],t[i-1]=s[i]-t[i]*Q[i]
        n=n-1       
    return a,s,t

tracemalloc.start()             #开始跟踪内存
a=int(input("a:"))
b=int(input("b:"))		#输入

start=time.perf_counter()	#开始计时
gdc,s,t=Euclid(a,b)		#计算最大公因数gdc和s、t
if(gdc<0):
    gdc=-gdc
    s=-s
    t=-t			#当b为负数时，gdc为负数；此处把gdc调整为正值
end=time.perf_counter()		#停止计时

print("gdc:%d s:%d t:%d"%(gdc,s,t,))
print("%.4fms"%((end-start)*1000))
print("%dkb"%((tracemalloc.get_traced_memory())[1]/1000))   #输出
