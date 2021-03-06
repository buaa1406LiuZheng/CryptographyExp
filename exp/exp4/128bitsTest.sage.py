# This file was *autogenerated* from the file 128bitsTest.sage
from sage.all_cmdline import *   # import sage library
_sage_const_2 = Integer(2); _sage_const_0 = Integer(0); _sage_const_16 = Integer(16)
sage.repl.load.load(sage.repl.load.base64.b64decode("QUVTLnNhZ2U="),globals(),False)
sage.repl.load.load(sage.repl.load.base64.b64decode("a2V5RXhwYW5zaW9uLnNhZ2U="),globals(),False)
sage.repl.load.load(sage.repl.load.base64.b64decode("c3Vic3RpdHV0aW9uLnNhZ2U="),globals(),False)

def Hex(i,WIDTH):
	s = hex(i)
	return "0"*(WIDTH-len(s))+s
def spiltByWidth(string,width):
	return [string[x:x+width] for x in range(_sage_const_0 ,len(string),width)]

plaintext = "0123456789abcdeffedcba9876543210"
key = 		"0f1571c947d9e8590cb7add6af7f6798"
cipher = 	"ff0b844a0853bf7c6934ab4364148fb9"

textGroup = spiltByWidth(plaintext,_sage_const_2 )
keyGroup = spiltByWidth(key,_sage_const_2 )
for i in range(_sage_const_0 ,_sage_const_16 ):
	textGroup[i] = int(textGroup[i],_sage_const_16 )
	keyGroup[i] = int(keyGroup[i],_sage_const_16 )

outGroup = AESEncrypt(textGroup,keyGroup)
#print(outGroup)
out = ""
for i in range(_sage_const_0 ,_sage_const_16 ):
	outGroup[i] = Hex(outGroup[i],_sage_const_2 )
	out+=outGroup[i]
print(outGroup)
print(out)
