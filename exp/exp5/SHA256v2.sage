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

def rightRotate(n,shamt,WIDTH=32):
	s = Bin(n,WIDTH)
	return long(s[len(s)-shamt:]+s[0:len(s)-shamt],2)
def rightShift(n,shamt,WIDTH=32):
	s = Bin(n,WIDTH)
	return long('0'*shamt+s[:len(s)-shamt],2)
def Not(b1):
	b1 = b1^^0xffffffff
	return b1

#Extend the first 16 words into the remaining 48 words w[16..63] of the message schedule array:
def ExtendW(chunk):
	w = spiltByWidth(chunk,8)
	for i in range(0,16):
		w[i] = long(w[i],16)
	for i in range(16,64):
		s0 = rightRotate(w[i-15],7) ^^ rightRotate(w[i-15],18) ^^ rightShift(w[i-15],3)	#(w[i-15] rightrotate 7) xor (w[i-15] rightrotate 18) xor (w[i-15] rightshift 3)
		s1 = rightRotate(w[i-2],17) ^^ rightRotate(w[i-2],19) ^^ rightShift(w[i-2],10)	#(w[i-2] rightrotate 17) xor (w[i-2] rightrotate 19) xor (w[i-2] rightshift 10)
		w.append((w[i-16] + s0 + w[i-7] + s1)%(1<<32))
	return w

def SHA256(m):
	#m is a hex string, return a 256bits hex-represent string

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
		w = ExtendW(chunk)
		#Initialize working variables to current hash value:
		a = h0
		b = h1
		c = h2
		d = h3
		e = h4
		f = h5
		g = h6
		h = h7
		#Compression function main loop:
		for i in range(0,64):
			S1 = rightRotate(e,6) ^^ rightRotate(e,11) ^^ rightRotate(e,25)		#(e rightrotate 6) xor (e rightrotate 11) xor (e rightrotate 25)
			ch = (e&f)^^(Not(e)&g)		#(e and f) xor ((not e) and g)
			temp1 = (h + S1 + ch + k[i] + w[i])%(1<<32)
			S0 = rightRotate(a,2) ^^ rightRotate(a,13) ^^ rightRotate(a,22)		#(a rightrotate 2) xor (a rightrotate 13) xor (a rightrotate 22)
			maj = ((a&b)^^(a&c)^^(b&c))		#(a and b) xor (a and c) xor (b and c)
			temp2 = (S0+maj)%(1<<32)
	 
			h = g
			g = f
			f = e
			e = (d+temp1)%(1<<32)
			d = c
			c = b
			b = a
			a = (temp1+temp2)%(1<<32)

	    #Add the compressed chunk to the current hash value:
		h0 = (h0 + a)%(1<<32)
		h1 = (h1 + b)%(1<<32)
		h2 = (h2 + c)%(1<<32)
		h3 = (h3 + d)%(1<<32)
		h4 = (h4 + e)%(1<<32)
		h5 = (h5 + f)%(1<<32)
		h6 = (h6 + g)%(1<<32)
		h7 = (h7 + h)%(1<<32)

	h0 = Hex(h0,8)
	h1 = Hex(h1,8)
	h2 = Hex(h2,8)
	h3 = Hex(h3,8)
	h4 = Hex(h4,8)
	h5 = Hex(h5,8)
	h6 = Hex(h6,8)
	h7 = Hex(h7,8)

	return h0+h1+h2+h3+h4+h5+h6+h7