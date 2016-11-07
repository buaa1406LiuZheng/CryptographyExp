load Euclid.sage
load modpow.sage

def commonMod(c1,e1,c2,e2,n):
	(gcd,s,t) = Euclid(e1,e2)
	if(gcd!=1):
		print("attack fail")
		return 0;
	t1 = modpow(c1,s,n)
	t2 = modpow(c2,t,n)
	return ((t1*t2)%n)