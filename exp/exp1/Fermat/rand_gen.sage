# -*- coding: utf-8 -*-

import random

f=open("input.txt",'w')         
i=10
j=0
while(j<9):                    #从i=10开始，生成1到i^2的随机数，并另i=i^2，循环9次
    i=i*i
    f.write(str(random.randrange(1,i,2))+'\n')
    j=j+1                                           #循环结束时，i=10^(2^9)
f.write(str(random.randrange(i+1,2*i,2))+'\n')        #生成从i到2i之间的随机数，保证有大数
f.close()
