from DES import *
from KeyGenerate import *
from binascii import *
from string import *

def Encrypt8Bytes(s,keyList):
	hexp = b2a_hex(s)
	hexc = DES(hexp,keyList)
	c = a2b_hex(hexc)
	return c

width = 8
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
	keyList.reverse()

s = ""
for line in fin:
	if(len(s)!=0):
		lenth = len(s)
		s = s+line[0:width-lenth]
		if(len(s)<8):
			continue
		line = line[width-lenth:]
		fout.write(Encrypt8Bytes(s,keyList))
		s = ""
	lineGroup = spiltByWidth(line,width)
	if(len(lineGroup)==0):
		continue
	for i in range(0,len(lineGroup)-1):
		s = lineGroup[i]
		fout.write(Encrypt8Bytes(s,keyList))
	s = lineGroup[len(lineGroup)-1]
	if(len(s)==width):
		fout.write(Encrypt8Bytes(s,keyList))
		s=""
#if lenth of plaintext is not a multiple of width
lenth = len(s)
if(lenth!=0):
	for i in range(0,width-lenth):
		s+=uppercase[i]
	fout.write(Encrypt8Bytes(s,keyList))

fin.close()
fout.close()
