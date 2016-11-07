load prime.sage
import random

def keyGen():

	p = getRandomPrime()
	while(True):
		a = random.randrange(1,p)
		b = random.randrange(1,p)
		if((4*a^3+27*b^2)!=0):	#Discriminant
			break
	R = IntegerModRing(p)
	E = EllipticCurve(R,[a,b])

	order = E.order()
	nA = random.randrange(1,order)
	G = E.gens()[0]
	PA = nA*G
	return (E,G,nA,PA)

def Encrypt(Pm,E,G,PA):
	order = E.order()
	k = random.randrange(1,order)
	C1 = k*G
	C2 = Pm+k*PA
	return (C1,C2)

def EncryptTest(Pm,E,G,PA,k):
	#just for testing Encryption
	C1 = k*G
	C2 = Pm+k*PA
	return (C1,C2)

def Decrypt(Cm,E,nA):
	C1 = Cm[0]
	C2 = Cm[1]
	return E(C2-nA*C1)