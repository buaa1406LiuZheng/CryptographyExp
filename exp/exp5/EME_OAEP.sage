load SHA256v2.sage
load DataTrans.sage
from random import *

def Xor(a,b,width):
	anum = long(a,16)
	bnum = long(b,16)
	return Hex(anum^^bnum,width)

def MGF(mgfSeed,maskLen):
	hLen = 256//4
	T = ""
	for counter in range(0,maskLen//hLen):
		C = I2OSP(counter,8)
		T+= SHA256(mgfSeed+C)
	return T[:hLen]

def EME_OAEP(M,L=""):
	#M is a hex-represent string
	#M's lenth must less then k-2*hLen-4(in this case 124)
	k=1024//4
	mLen = len(M)
	hLen=256//4

	lHash = SHA256(L)
	PS = '0'*(k-mLen-2*hLen-4)
	DB = lHash+PS+"01"+M

	seed = randint(0,1<<hLen)
	seed = Hex(seed,hLen)

	dbMask = MGF(seed,k-hLen-2)
	maskedDB = Xor(DB,dbMask,k-hLen-2)

	seedMask = MGF(maskedDB,hLen)
	maskedSeed = Xor(seed,seedMask,hLen)

	EM = "00"+maskedSeed+maskedDB
	return EM

def EME_OAEP_Inverse(EM,L=""):
	k=1024//4
	hLen=256//4

	maskedSeed = EM[2:2+hLen]
	maskedDB = EM[2+hLen:]

	seedMask = MGF(maskedDB,hLen)
	seed = Xor(maskedSeed,seedMask,hLen)

	dbMask = MGF(seed,k-hLen-2)
	DB = Xor(maskedDB,dbMask,k-hLen-2)

	PSandM = DB[hLen:]

	i=0
	while(PSandM[i]=='0'):
		i=i+1
	M = PSandM[i+1:]
	return M