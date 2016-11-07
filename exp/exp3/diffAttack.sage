from Permutation import *
from DES3R import *
from DES import *
from random import *

#Xor 2 Binary String, output width fixed
def Xor(in1,in2,width):
	a = long(in1,2)
	b = long(in2,2)
	c = a^^b
	return Bin(c,width)

#get a possible Round3 Keys' set using a randomly generate plaintext
def getKeySet():
	while(True):
		La = randint(0,1<<32)
		Lb = randint(0,1<<32)
		R = randint(0,1<<32)

		L0a = Bin(La,32)
		L0b = Bin(Lb,32)
		R0 = Bin(R,32)
		L0x = Xor(L0a,L0b,32)

		ma = L0a+R0
		mb = L0b+R0
		Ca = DES3R(ma)
		Cb = DES3R(mb)
		ca = Bin(long(Ca,16),64)
		cb = Bin(long(Cb,16),64)

		L3a = ca[0:32]
		R3a = ca[32:64]
		L3b = cb[0:32]
		R3b = cb[32:64]
		R3x = Xor(R3a,R3b,32)

		R2a = L3a
		R2b = L3b
		#bits out of expansion of the R2
		REa = Expansion(R2a)
		REb = Expansion(R2b)
		REx = Xor(REa,REb,48)

		Sinx = REx
		L2x = L0x # L2 = R1 = L0^^F(K,R0)
		Soutx = P32Inverse(Xor(R3x,L2x,32))

		SinGroup = spiltByWidth(Sinx,6)
		SoutGroup = spiltByWidth(Soutx,4)
		potentialIn = []

		#find the potential input of the SBox
		for groupNum in range(0,8):
			i=0
			potentialInGroup = []
			while(i<(1<<6)):
				ta = Bin(i,6)
				tb = Xor(ta,SinGroup[groupNum],6)
				sa = SingleSBox(ta,groupNum)
				sb = SingleSBox(tb,groupNum)
				if(Xor(sa,sb,4) == SoutGroup[groupNum]):
					potentialInGroup.append(ta)
				i=i+1
			potentialIn.append(potentialInGroup)

		count = 1
		for i in range(0,8):
			count*=len(potentialIn[i])
		if(count<2000000):
			break
	#combination generate
	m = [0]*8
	potentialKey = []
	while(True):
		s=""
		for i in range(0,8):
			s += potentialIn[i][m[i]]
		potentialKey.append(Xor(s,REa,48))
		m[0]+=1
		flag = False
		for i in range(0,8):
			if(m[i]==len(potentialIn[i])):
				m[i]=0
				if(i!=7):
					m[i+1]+=1
				else:
					flag = True
					break
			else:
				break
		if(flag):
			break

	return set(potentialKey)

#use the 48bits round2 Key to get all possibel original 56bits keys
def getOriginalKeySet(key):
	keyset = set()
	for i in range(0,1<<8):
		key2 = PC2Inverse(key,Bin(i,8))
		width = 28
		keyGroup = spiltByWidth(key2,width)
		#both group shift right 4 bits
		keyGroup[0] = keyGroup[0][width-4:]+keyGroup[0][0:width-4]
		keyGroup[1] = keyGroup[1][width-4:]+keyGroup[1][0:width-4]
		keyset.add(keyGroup[0]+keyGroup[1])
	return(keyset)

#filter out wrong 56bits key
def filterKey(keyset):
	while(len(keyset)!=1):
		key = keyset.pop()
		M = randint(0,1<<64)
		m = Bin(M,64)
		c = DES3R(m)
		ctest = DES3RTest(m,key)
		if(c == ctest):
			keyset.add(key)
	return(keyset.pop())

#to test correctness,make sure the original key is the same as key in DES3R.py
keyOrigin = "3f3b57d61e327a82"
keyList = getKey(keyOrigin)
k3 = keyList[2]

key48set = getKeySet()
while(len(key48set)!=1):
	#for test
	print("len"+str(len(key48set)))
	if(k3 not in key48set):
		print("error")
		break

	key48set = key48set & getKeySet()

key = key48set.pop()
key56set = getOriginalKeySet(key)
key56 = filterKey(key56set)
#key56 is the key derived from original Permutation of Original 64bits key
print(key56)
print(key56 == keyInitial(keyOrigin))
#k2 = keyList[2]
#print(k2)
#print(key==k2)