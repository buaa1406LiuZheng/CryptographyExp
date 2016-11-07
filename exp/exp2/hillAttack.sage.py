# This file was *autogenerated* from the file hillAttack.sage
from sage.all_cmdline import *   # import sage library
_sage_const_30000 = Integer(30000); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_26 = Integer(26); _sage_const_4 = Integer(4)
import random

def dig(p):
	if(p.isalpha):
		p = p.lower()
		return ord(p)-ord('a')


fplant = open("HillDecrypt.txt",'r')
fcipher = open("HillEncrypt.txt",'r')
R = IntegerModRing(_sage_const_26 )

text = fplant.readline(_sage_const_30000 )
ctext = fcipher.readline(_sage_const_30000 )
lenth = len(text)
m=_sage_const_4 

pnum = []
record = []
while(true):
	for i in range(_sage_const_0 ,m):
		i = random.randint(_sage_const_0 ,lenth//m-_sage_const_1 )
		record.append(i)
		pgroup=[]
		for j in range(_sage_const_0 ,m):
			pgroup.append(dig(text[m*i+j]))
		pnum.append(pgroup)
	p = matrix(R,pnum)
	if(gcd(p.det(),_sage_const_26 )!=_sage_const_1 ):
		pnum=[]
		record = []
	else:
		break

cnum = []
for i in record:
	cgroup = []
	for j in range(_sage_const_0 ,m):
		cgroup.append(dig(ctext[m*i+j]))
	cnum.append(cgroup)

c = matrix(R,cnum)

key = (p**-_sage_const_1 )*c
print(key)

fcipher.close()
fplant.close()