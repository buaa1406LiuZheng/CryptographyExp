load prime.sage
import hashlib

def Setup():

	q = getRandomPrime()

	#randomly generate p and q
	i=0
	while(True):
		l = random.randint(1,q)
		p = l*q-1
		if(p%3==2 and PrimeTest(p)):
			break
		i+=1
		if(i==100):
			#in case p is hard to find, change a q
			i=0
			q = getRandomPrime()

	R = IntegerModRing(p)
	E = EllipticCurve(R,[0,1])
	
	P0 = E.random_point()	#P0 is E's generator
	P = l*P0	#P is order q generator
	s = random.randint(1,q)	#s is master key
	Ppub = s*P 	#Ppub is public key

	return (p,q,P,Ppub,s)

def H1(m,p,q):
	#given an m, then y = m%p, x = (y^2-1)^((2p-1)/3), (x,y) is a point in E
	R = IntegerModRing(p)
	E = EllipticCurve(R,[0,1])

	mhex = hashlib.sha256(m).hexdigest()
	y = R(long(mhex,16))
	x = modpow(y^2-1,(2*p-1)//3,p)
	Q = E(x,y)

	l = (p+1)//q
	QID = l*Q
	return QID

def H2(e):
	#transform a poly to an int
	e = str(e)
	try:
		i1 = e.index('*')
		c1 = long(e[0:i1])
		i2 = e.index('+')
		c2 = long(e[i2:])
	except Exception, E:
		return 1
	
	return (p*c1+c2)%(p^2)

def H3(a,b,q):
	a = str(a)
	b = str(b)
	h1 = hashlib.sha256(a).hexdigest()
	h2 = hashlib.sha256(b).hexdigest()
	return (long(h1,16)+long(h2,16))%q

def H4(a,p):
	a = str(a)
	h = hashlib.sha256(a).hexdigest()
	return (long(h,16))%(p^2)

def Extract(ID,p,q,s):
	# R = IntegerModRing(p)
	# E = EllipticCurve(R,[0,1])

	QID = H1(ID,p,q)
	dID = s*QID

	return dID

v = 0
def bilinear(p,q,P,Q,isEncrypt,r=0):
	# modified Weil pairing
	
	R2 = GF(p^2,name = 'm')
	E2 = EllipticCurve(R2,[0,1])
	P = E2(P)
	x = Q[0]
	y = Q[1]

	global v
	#find a v such that v^3==1 and v!=1
	if(isEncrypt):		
		g2 = R2.gen()
		v = g2^((p^2-1)//3)

	Q = E2(v*x,y)
	e = P.weil_pairing(Q,Integer(q))

	return e

def Encrypt(p,q,P,Ppub,ID,M):
	# R = IntegerModRing(p^2)
	# E = EllipticCurve(R,[0,1])

	d = random.randint(1,p^2)
	r = H3(d,M,q)

	C1 = r*P
	QID = H1(ID,p,q)
	gID = bilinear(p,q,QID,Ppub,true,r)
	C2 = d ^^ H2(gID^r)
	C3 = M ^^ H4(d,p)

	return (C1,C2,C3)

def Decrypt(p,q,C,dID,P):

	# R = IntegerModRing(p)
	# E = EllipticCurve(R,[0,1])
	U = C[0]
	V = C[1]
	W = C[2]

	gID = bilinear(p,q,dID,U,false)
	d = V ^^ H2(gID)
	M = W ^^ H4(d,p)
	r = H3(d,M,q)
	if(U == r*P):
		return M
	else:
		raise Exception("DECRYPT REJECT")