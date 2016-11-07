import random

f=open("input.txt",'w')
a=10
for i in range(1,10):   #生成10的从1到九次方内的随机数，作为第1到第九组输入
    b=a**i
    f.write(str(random.randint(1,b))+' ')
    f.write(str(random.randint(1,b))+' ')
    f.write(str(random.randint(1,b))+'\n')
b=b*(2**1000)           #生成随机大整数作为最后一组输入
f.write(str(random.randint(1,b))+' ')
f.write(str(random.randint(1,b))+' ')
f.write(str(random.randint(1,b))+'\n')
f.close()
