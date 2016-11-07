import random
load MillerRabin.sage
load Euclid.sage

def keyGen(e = (1<<16)+1):

	while(True):
		p = getRandomPrime()
		q = getRandomPrime()
		n = p*q
		phi_n = (p-1)*(q-1)

		(gcd,d,t) = Euclid(e,phi_n)
		
		if(gcd == 1):
			break
	d = d%phi_n
	if(((d*e)%phi_n)!=1):
			print("error")
	return (p,q,e,d,n,phi_n)

def keyGenGivenN(p,q,e = (1<<16)+1):

	n = p*q
	phi_n = (p-1)*(q-1)

	(gcd,d,t) = Euclid(e,phi_n)

	d = d%phi_n
	if(((d*e)%phi_n)!=1):
			print("error N")
	return (p,q,e,d,n,phi_n)

def getRandomPrime():

	primeLen = 520
	maxPrime = 1<<primeLen
	while(True):
		rand = random.randrange(maxPrime//2+1,maxPrime,2)
		if(PrimeTest(rand)):
			break
	return rand