# This file was *autogenerated* from the file AesFile.sage
from sage.all_cmdline import *   # import sage library
sage.repl.load.load(sage.repl.load.base64.b64decode("QWVzQ0JDLnNhZ2U="),globals(),False)

IV =  "0123456789abcdeffedcba9876543210"
key = "0f1571c947d9e8590cb7add6af7f6798"

while(true):
	mode = raw_input("encrypt/decrypt? e/d:")
	if(mode == 'e' or mode == 'd'):
		break
if(mode == 'e'):
	fin = open("text.txt",'r')
	fout = open("AESEncrypt.txt",'w')
	AesCBC(fin,fout,mode,IV,key)
else:
	fin = open("AESEncrypt.txt",'r')
	fout = open("AESDecrypt.txt",'w')
	AesCBC(fin,fout,mode,IV,key)

fin.close()
fout.close()
