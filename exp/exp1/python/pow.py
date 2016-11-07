import time

def modpow1(b,n,m):              #利用模重复平方算法计算b^n(mod m)
    a=1
    while(n!=0):
        r=n%2                   #这一步与n=n//2即把n拆成一个二进制数
        if(r==1):
            a=(a*b)%m           
        b=(b*b)%m               #模的平方
        n=n//2
    return a
def modpow2(b,n,m):             #普通算法1，每次乘b后取模
    a=1
    while(n>0):
        a=(a*b)%m
        n=n-1
    return a
def modpow3(b,n,m):             #普通算法2，计算完b^n后再取模
    return (b**n)%m

fin=open("input.txt",'r')
fout=open("output.txt",'w')
i=1
for line in fin:
    nums=line.split()           #每一行的三个整数存入nums
    
    start1=time.perf_counter()
    result1=modpow1(int(nums[0]),int(nums[1]),int(nums[2]))
    end1=time.perf_counter()
    runtime1=(end1-start1)*1000
    fout.write("result1:"+str(result1)+" runtime1:"+str(runtime1)+"ms\n")
    if(i<=8):                    #限制输入大小使普通算法能在可行时间内运行完
        start2=time.perf_counter()
        result2=modpow2(int(nums[0]),int(nums[1]),int(nums[2]))
        end2=time.perf_counter()
        runtime2=(end2-start2)*1000
        fout.write("result2:"+str(result2)+" runtime2:"+str(runtime2)+"ms\n")
    if(i<=6):
        start3=time.perf_counter()
        result3=modpow3(int(nums[0]),int(nums[1]),int(nums[2]))
        end3=time.perf_counter()
        runtime3=(end3-start3)*1000
        fout.write("result3:"+str(result3)+" runtime3:"+str(runtime3)+"ms\n")
    i=i+1
    fout.write("\n")

fin.close()
fout.close()
