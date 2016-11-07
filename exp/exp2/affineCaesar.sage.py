# This file was *autogenerated* from the file affineCaesar.sage
from sage.all_cmdline import *   # import sage library
_sage_const_1 = Integer(1); _sage_const_26 = Integer(26); _sage_const_9 = Integer(9); _sage_const_15 = Integer(15)
n=_sage_const_26 
R = IntegerModRing(n)

def encrypt(a,b,p):
	if(gcd(a,n)==_sage_const_1 ): 			#make sure key 'a' is invertible
		return R(a*p+b)
	else:
		print("invalid key")
		return -_sage_const_1 

def decrypt(a,b,c):
	if(gcd(a,n)==_sage_const_1 ):
		return R((c-b)*a**-_sage_const_1 )
	else:
		print("invalid key")
		return -_sage_const_1 

def dig(p):
	p = p.lower()
	return ord(p)-ord('a')
def char(num):
	return chr(int(num)+ord('a'))

a = _sage_const_15 
b = _sage_const_9 

while(true):
	choose = raw_input("decrypt or encrypt? d/e:")
	if(choose == "d" or choose =="e"):
		break

if(choose == "e"):
	fin = open("text.txt",'r')
	fout = open("Caesar.txt",'w')
	for line in fin:
		for p in line:
			if(p.isalpha()):
				num = encrypt(a,b,dig(p))
				fout.write(char(int(num)))
			else:
				fout.write(p)
elif(choose == "d"):
	fin = open("Caesar.txt",'r')
	fout = open("CaesarDecrypt.txt",'w')
	for line in fin:
		for p in line:
			if(p.isalpha()):
				num = decrypt(a,b,dig(p))
				fout.write(char(int(num)))
			else:
				fout.write(p)

fin.close()
fout.close()