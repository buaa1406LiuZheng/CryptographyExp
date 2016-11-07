from Permutation import *
from RoundFunction import *
from KeyGenerate import *

def DES3R(p):
	keyList = getKey("3f3b57d61e327a82")
	L = p[0:32]
	R = p[32:64]
	for i in range(0,3):
		key = keyList[i]
		(L,R) = RoundFunction((L,R),key)
	c = L+R
	c = Hex(long(c,2),16)
	return c

def DES3RTest(p,key):
	keyList = []
	key = ShiftLeft(key,1)
	keyList.append(PC2(key))
	key = ShiftLeft(key,1)
	keyList.append(PC2(key))
	key = ShiftLeft(key,2)
	keyList.append(PC2(key))
	L = p[0:32]
	R = p[32:64]
	for i in range(0,3):
		key = keyList[i]
		(L,R) = RoundFunction((L,R),key)
	c = L+R
	c = Hex(long(c,2),16)
	return c