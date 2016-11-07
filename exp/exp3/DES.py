from Permutation import *
from RoundFunction import *

#plaintext = "liuzheng"
#key = "LiuZheng"
#hex_p = "02468aceeca86420"
#pNum = long(b2a_hex(plaintext),16)

def DES(inputHex,keyList):
	pnum = long(inputHex,16)
	p = Bin(pnum,64)
	p = IP(p)
	L = p[0:32]
	R = p[32:64]
	for i in range(0,16):
		key = keyList[i]
		(L,R) = RoundFunction((L,R),key)
	c = R+L
	c = IPInverse(c)
	c = Hex(long(c,2),16)
	return c
