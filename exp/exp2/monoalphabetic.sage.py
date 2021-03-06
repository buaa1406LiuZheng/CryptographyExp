# This file was *autogenerated* from the file monoalphabetic.sage
from sage.all_cmdline import *   # import sage library
_sage_const_1 = Integer(1); _sage_const_0 = Integer(0)
fkey = open("monoKey.txt",'r')
fin = open("text.txt",'r')
fout = open("monoEncrypt.txt",'w')

keylist = {}
for key in fkey:
	key = key.split()
	p = key[_sage_const_0 ]
	k = key[_sage_const_1 ]
	keylist[p]=k

for line in fin:
	for p in line:
		if(p.isalpha()):
			fout.write(keylist[p.lower()])
		else:
			fout.write(p)

fkey.close()
fin.close()
fout.close()
