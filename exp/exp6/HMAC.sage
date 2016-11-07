load SHA1.sage

def HMAC(key,m):
	#key and m are hex strings

	b=512

	#if key lenth greater than b, hash key to n bits(in SHA1, n=160)
	if((len(key)*4)>b):
		key = SHA1(key)		#key is still in hex form
	#padding
	keyPlus = key+'0'*(b//4-len(key))

	#generate ipad and opad
	ipad = "36"*(b//8)
	opad = "5c"*(b//8)
	ipad = long(ipad,16)
	opad = long(opad,16)

	#get ipad and opad
	kNum = long(keyPlus,16)
	si = kNum ^^ ipad
	so = kNum ^^ opad
	si = Hex(si,128)
	so = Hex(so,128)

	#calculate hash value
	H1 = SHA1(si+m)
	H2 = SHA1(so+H1)

	return H2