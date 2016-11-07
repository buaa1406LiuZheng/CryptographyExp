load CRT.sage

def smallPow(c1,c2,c3,n1,n2,n3):
	c = [c1,c2,c3]
	n = [n1,n2,n3]
	(mcube,ncube) = CRT(c,n,3)
	m = mcube^(1/3)
	return m

def smallPow_fixE(c,n,e):
	(mpow,npow) = CRT(c,n,e)
	m = mpow^(1/e)
	return m