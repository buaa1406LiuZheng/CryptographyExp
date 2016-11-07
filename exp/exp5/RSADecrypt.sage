load modpow.sage
load CRT.sage

def RSADecrypt(c,d,p,q):

	b = []
	mod = [p,q]
	b.append(modpow(c,d,p))
	b.append(modpow(c,d,q))

	(m,n) = CRT(b,mod,2)
	return m

def RSADecrypt2(c,d,n):

	return modpow(c,d,n)