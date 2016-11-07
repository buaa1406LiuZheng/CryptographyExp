from DES import *
from KeyGenerate import *
from binascii import *
from string import *

def Encrypt8Bytes(plaintext,keyList,hexVector):
	hexp = b2a_hex(plaintext)
	hexO = DES(hexVector,keyList)
	Onum = long(hexO,16)
	pnum = long(hexp,16)
	cnum = Onum^^pnum
	hexc = Hex(cnum,16)
	hexVector = Hex(Onum,16)
	c = a2b_hex(hexc)
	return (c,hexVector)

width = 8
hexVector = "1234567890abcdef"
keyHex = "0f1571c847d9e859"
keyList = getKey(keyHex)

while(true):
	select = raw_input("encrypt/decrypt? e/d:")
	if(select == 'e' or select == 'd'):
		break
if(select == 'e'):
	fin = open("text.txt",'r')
	fout = open("DESEncrypt.txt",'w')
else:
	fin = open("DESEncrypt.txt",'r')
	fout = open("DESDecrypt.txt",'w')

s = ""
for line in fin:
	if(len(s)!=0):
		lenth = len(s)
		s = s+line[0:width-lenth]
		if(len(s)<8):
			continue
		line = line[width-lenth:]
		(c,hexVector) = Encrypt8Bytes(s,keyList,hexVector)
		s=""
		fout.write(c)
	lineGroup = spiltByWidth(line,width)
	if(len(lineGroup)==0):
		continue
	for i in range(0,len(lineGroup)-1):
		s = lineGroup[i]
		(c,hexVector) = Encrypt8Bytes(s,keyList,hexVector)
		fout.write(c)
	s = lineGroup[len(lineGroup)-1]
	if(len(s)==width):
		(c,hexVector) = Encrypt8Bytes(s,keyList,hexVector)
		fout.write(c)
		s=""
#if lenth of plaintext is not a multiple of width
lenth = len(s)
if(lenth!=0):
	for i in range(0,width-lenth):
		s+=uppercase[i]
	(c,hexVector) = Encrypt8Bytes(s,keyList,hexVector)
	fout.write(c)

fin.close()
fout.close()