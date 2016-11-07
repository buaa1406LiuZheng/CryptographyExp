load Euclid.sage

def modpow(b,n,m):
	#模重复平方算法计算b^n(mod m)

	if(n<0):
		(gcd,bInverse,t) = Euclid(b,m)
		if(gcd!=1):
			print("n<0 and b have no Inverse")
		else:
			return modpow(bInverse,-n,m)
	else:
	    a=1
	    while(n!=0):
	        r=n%2
	        if(r==1):
	            a=(a*b)%m
	        b=(b*b)%m
	        n=n//2
	    return a