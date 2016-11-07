load AES.sage

from binascii import *

def Hex(i,WIDTH):
	s = hex(i)
	if(len(s)>2):
		s = s[2:]
	return "0"*(WIDTH-len(s))+s
def spiltByWidth(string,width):
	return [string[x:x+width] for x in range(0,len(string),width)]

#transfer ascii to int
def text2int(text):
	textHex = []
	for c in text:
		textHex.append(b2a_hex(c))
	textInt = []
	for h in textHex:
		textInt.append(int(h,16))
	return textInt
#transfer int to ascii
def int2text(textInt):
	textHex = []
	
	for i in textInt:
		textHex.append(Hex(i,2))
	s = ""
	for h in textHex:	
		s+=a2b_hex(h)
	return s

#encrypt 16Bytes group, plaintext is a List contain 16 int
#return next HexVector and output text
def Encrypt16Bytes(s,keyGroup,hexVector):
	plaintext = text2int(s)

	for i in range(0,16):
		plaintext[i] = plaintext[i]^^hexVector[i]

	hexVector = AESEncrypt(plaintext,keyGroup)

	out = int2text(hexVector)
	return (out,hexVector)
#Decrypt 16Bytes group, plaintext is a List contain 16 int
def Decrypt16Bytes(s,keyGroup,hexVector):
	ciphertext = text2int(s)

	decryptGroup = AESDecrypt(ciphertext,keyGroup)

	for i in range(0,16):
		decryptGroup[i] = decryptGroup[i]^^hexVector[i]
	out = int2text(decryptGroup)

	return (out,ciphertext)

def AesCBC(fin,fout,mode,IV,key):

	hexVector = spiltByWidth(IV,2)
	keyGroup = spiltByWidth(key,2)
	for i in range(0,16):
		hexVector[i] = int(hexVector[i],16)
		keyGroup[i] = int(keyGroup[i],16)

	while(True):
		s = fin.read(16)
		
		if(len(s)<16):
			break
		if(mode == 'e'):
			(out,hexVector) = Encrypt16Bytes(s,keyGroup,hexVector)
		else:
			(out,hexVector) = Decrypt16Bytes(s,keyGroup,hexVector)
		fout.write(out)
	if(mode == 'e'):
		#the last group
		lackNum = 16-len(s)
		if(lackNum == 16):
			addChar = '0'
		else:
			addChar = hex(lackNum)
		for i in range(0,lackNum):
			s+=addChar
		plaintext = text2int(s)
		(out,hexVector) = Encrypt16Bytes(s,keyGroup,hexVector)
		fout.write(out)