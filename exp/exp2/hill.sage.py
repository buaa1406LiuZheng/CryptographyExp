# This file was *autogenerated* from the file hill.sage
from sage.all_cmdline import *   # import sage library
_sage_const_3 = Integer(3); _sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_7 = Integer(7); _sage_const_6 = Integer(6); _sage_const_5 = Integer(5); _sage_const_4 = Integer(4); _sage_const_13 = Integer(13); _sage_const_12 = Integer(12); _sage_const_17 = Integer(17); _sage_const_22 = Integer(22); _sage_const_19 = Integer(19); _sage_const_18 = Integer(18); _sage_const_26 = Integer(26); _sage_const_20 = Integer(20)
def dig(p):
	if(p.isalpha):
		p = p.lower()
		return ord(p)-ord('a')
def char(num):
	return chr(int(num)+ord('a'))

def HillEncrypt(key,m,R,fin,fout):
	i=_sage_const_0 
	pnum = []
	pgroup=[]
	for line in fin:
		for p in line:
			if(p.isalpha()):
				pgroup.append(dig(p))
				i=(i+_sage_const_1 )%m
				if(i==_sage_const_0 ):
					pnum.append(pgroup)
					pgroup = []
	if(i!=_sage_const_0 ):				#if len(p)%m!=0,then append 0 to the end of p
		while(i!=_sage_const_0 ):
			i=(i+_sage_const_1 )%m
			pgroup.append(_sage_const_0 )
		pnum.append(pgroup)
	c = matrix(R,pnum)*key;
	for cgroup in c:
		for cnum in cgroup:
			fout.write(char(cnum))

def HillDecrypt(key,m,R,fin,fout):
	i=_sage_const_0 
	cnum = []
	cgroup=[]
	for line in fin:
		for c in line:
			if(c.isalpha()):
				cgroup.append(dig(c))
				i=(i+_sage_const_1 )%m
				if(i==_sage_const_0 ):
					cnum.append(cgroup)
					cgroup = []
	if(i!=_sage_const_0 ):
		while(i!=_sage_const_0 ):
			i=(i+_sage_const_1 )%m
			cgroup.append(_sage_const_0 )
		cnum.append(cgroup)
	p = matrix(R,cnum)*(key**-_sage_const_1 );
	for pgroup in p:
		for pnum in pgroup:
			fout.write(char(pnum))


fplant = open("text.txt",'r')
fdecrypt = open("HillDecrypt.txt",'w')

while(true):
	choose = raw_input("decrypt or encrypt? d/e:")
	if(choose == "d" or choose =="e"):
		break


R = IntegerModRing(_sage_const_26 )
m = _sage_const_4 
key = matrix(R,[[_sage_const_19 ,_sage_const_12 ,_sage_const_17 ,_sage_const_13 ],[_sage_const_4 ,_sage_const_20 ,_sage_const_6 ,_sage_const_3 ],[_sage_const_19 ,_sage_const_13 ,_sage_const_7 ,_sage_const_5 ],[_sage_const_5 ,_sage_const_22 ,_sage_const_18 ,_sage_const_19 ]])
if(gcd(_sage_const_26 ,key.det())!=_sage_const_1 ):
	print("invalid key")
else:
	if(choose=="e"):
		fcipher = open("HillEncrypt.txt",'w')
		HillEncrypt(key,m,R,fplant,fcipher)
	else:
		fcipher = open("HillEncrypt.txt",'r')
		HillDecrypt(key,m,R,fcipher,fdecrypt)

fplant.close()
fdecrypt.close()
fcipher.close()