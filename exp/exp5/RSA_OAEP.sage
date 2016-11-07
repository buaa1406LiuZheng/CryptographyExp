load EME_OAEP.sage
load DataTrans.sage
load RSAEncrypt.sage
load RSADecrypt.sage

def RSA_OAEP_Encrypt(M,(e,n),L=""):
	#M is hex
	k=1024//4
	EM = EME_OAEP(M,L)
	m=OS2IP(EM)

	c=RSAEncrypt(m,e,n)
	C=I2OSP(c,k)
	return C

def RSA_OAEP_Decrypt(C,(d,p,q),L=""):
	c=OS2IP(C)
	m = RSADecrypt(c,d,p,q)

	EM = I2OSP(m,1024//4)
	M = EME_OAEP_Inverse(EM,L)
	return M