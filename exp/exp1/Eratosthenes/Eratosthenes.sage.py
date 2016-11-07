# This file was *autogenerated* from the file Eratosthenes.sage
from sage.all_cmdline import *   # import sage library
_sage_const_3 = Integer(3); _sage_const_2 = Integer(2); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_10 = Integer(10)
def Eratosthenes(n):
	numList = [_sage_const_0 ]*(n+_sage_const_1 )
	i=_sage_const_3 
	while(i*i<=n):
		if(numList[i]==_sage_const_0 ):
			j=_sage_const_2 *i
			while(j<n):
				numList[j]=_sage_const_1 
				j+=i
		i=i+_sage_const_2 
	cnt=_sage_const_1 
	fout.write("2 ")
	for i in range(_sage_const_3 ,n+_sage_const_1 ,_sage_const_2 ):
		if(numList[i]==_sage_const_0 ):
			fout.write(str(i)+' ')
			cnt=cnt+_sage_const_1 
			if((cnt%_sage_const_10 )==_sage_const_0 ):
				fout.write('\n')
	fout.write("\ntotal:"+str(cnt))
	return

fout=open("output.txt","w")

n=int(input("input a num:\n"))
Eratosthenes(n)

fout.close()
