from math import *

#Initialize array of round constants:
#(first 32 bits of the fractional parts of the cube roots of the first 64 primes 2..311):
k=[0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,\
   0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,\
   0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,\
   0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,\
   0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,\
   0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,\
   0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,\
   0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2]

def spiltByWidth(string,width):
	return [string[x:x+width] for x in range(0,len(string),width)]
def Bin(i,*WIDTH):
	s = bin(i)
	if(s[0:2]=="0b"):
		s=s[2:]
	if(s[len(s)-1]=="L"):
		s = s[0:len(s)-1]
	if(len(WIDTH)==0):
		return s
	else:
		return "0"*(WIDTH[0]-len(s))+s
def Hex(i,*WIDTH):
	s = hex(i)
	if(s[0:2]=="0x"):
		s = s[2:]
	if(s[len(s)-1]=="L"):
		s = s[0:len(s)-1]
	if(len(WIDTH)==0):
		return s
	else:
		return "0"*(WIDTH[0]-len(s))+s

def rightRotate(s,shamt):
	#s is binary form, rotate shift s by shamt
	return s[len(s)-shamt:]+s[0:len(s)-shamt]
def rightShift(s,shamt):
	#s is binary form, rotate shift s by shamt
	return '0'*shamt+s[:len(s)-shamt]
def Xor(b1,b2):
	#b1 b2 must equal in lenth and are binary form
	s = ""
	for i in range(0,len(b1)):
		if(b1[i]==b2[i]):
			s+='0'
		else:
			s+='1'
	return s
def And(b1,b2):
	#b1 b2 must equal in lenth and are binary form
	s = ""
	for i in range(0,len(b1)):
		if(b1[i]=='1' and b2[i]=='1'):
			s+='1'
		else:
			s+='0'
	return s
def Not(b1):
	#b1 must be binary form
	s = ""
	for i in range(0,len(b1)):
		if(b1[i]=='0'):
			s+='1'
		else:
			s+='0'
	return s

#Extend the first 16 words into the remaining 48 words w[16..63] of the message schedule array:
def ExtendW(chunk):
	w = spiltByWidth(chunk,32)
	for i in range(16,64):
		s0 = Xor(Xor(rightRotate(w[i-15],7),rightRotate(w[i-15],18)),rightShift(w[i-15],3))	#((w[i-15] rightrotate 7) xor (w[i-15] rightrotate 18) xor (w[i-15] rightshift 3)
		s1 = Xor(Xor(rightRotate(w[i-2],17),rightRotate(w[i-2],19)),rightShift(w[i-2],10))		#(w[i-2] rightrotate 17) xor (w[i-2] rightrotate 19) xor (w[i-2] rightshift 10
		#w.append(w[i-16] + s0 + w[i-7] + s1)
		w.append(Bin((long(w[i-16],2) + long(s0,2) + long(w[i-7],2) + long(s1,2))%(1<<32),32))
	return w

def SHA256(m):
	#Initialize hash values:
	#(first 32 bits of the fractional parts of the square roots of the first 8 primes 2..19):
	h0 = 0x6a09e667
	h1 = 0xbb67ae85
	h2 = 0x3c6ef372
	h3 = 0xa54ff53a
	h4 = 0x510e527f
	h5 = 0x9b05688c
	h6 = 0x1f83d9ab
	h7 = 0x5be0cd19

	#Pre-processing:
	if(m==""):
		mBin=""
	else:
		mBin = Bin(long(m,16))
	mlen = len(mBin)
	mPaddingBin = "1"
	count = mlen+1
	while((count%512!=448)):
		mPaddingBin+="0"
		count+=1
	mPaddingBin = mBin+mPaddingBin
	mPaddingHex = Hex(int(mPaddingBin,2))
	mlenHex = Hex(mlen,16)
	mPaddingHex += mlenHex
	M = spiltByWidth(mPaddingHex,128)

	#Process the message in successive 512-bit chunks:
	for chunk in M:
		chunk = Bin(long(chunk,16),512)
		w = ExtendW(chunk)

		#Initialize working variables to current hash value:
		a = Bin(h0,32)
		b = Bin(h1,32)
		c = Bin(h2,32)
		d = Bin(h3,32)
		e = Bin(h4,32)
		f = Bin(h5,32)
		g = Bin(h6,32)
		h = Bin(h7,32)
		#Compression function main loop:
		for i in range(0,64):
			S1 = Xor(Xor(rightRotate(e,6),rightRotate(e,11)),rightRotate(e,25))		#(e rightrotate 6) xor (e rightrotate 11) xor (e rightrotate 25)
			ch = Xor(And(e,f),And(Not(e),g))		#(e and f) xor ((not e) and g)
			temp1 = Bin((long(h,2) + long(S1,2) + long(ch,2) + k[i] + long(w[i],2))%(1<<32),32)
			S0 = Xor(Xor(rightRotate(a,2),rightRotate(a,13)),rightRotate(a,22))		#(a rightrotate 2) xor (a rightrotate 13) xor (a rightrotate 22)
			maj = Xor(Xor(And(a,b),And(a,c)),And(b,c))		#(a and b) xor (a and c) xor (b and c)
			temp2 = Bin((long(S0,2) + long(maj,2))%(1<<32),32)
	 
			h = g
			g = f
			f = e
			e = Bin((long(d,2) + long(temp1,2))%(1<<32),32)
			d = c
			c = b
			b = a
			a = Bin((long(temp1,2) + long(temp2,2))%(1<<32),32)

	    #Add the compressed chunk to the current hash value:
		h0 = (h0 + long(a,2))%(1<<32)
		h1 = (h1 + long(b,2))%(1<<32)
		h2 = (h2 + long(c,2))%(1<<32)
		h3 = (h3 + long(d,2))%(1<<32)
		h4 = (h4 + long(e,2))%(1<<32)
		h5 = (h5 + long(f,2))%(1<<32)
		h6 = (h6 + long(g,2))%(1<<32)
		h7 = (h7 + long(h,2))%(1<<32)

	h0 = Hex(h0,8)
	h1 = Hex(h1,8)
	h2 = Hex(h2,8)
	h3 = Hex(h3,8)
	h4 = Hex(h4,8)
	h5 = Hex(h5,8)
	h6 = Hex(h6,8)
	h7 = Hex(h7,8)

	return h0+h1+h2+h3+h4+h5+h6+h7