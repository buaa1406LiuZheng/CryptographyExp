# This file was *autogenerated* from the file testRSA.sage
from sage.all_cmdline import *   # import sage library
sage.repl.load.load(sage.repl.load.base64.b64decode("a2V5R2VuLnNhZ2U="),globals(),False)
sage.repl.load.load(sage.repl.load.base64.b64decode("UlNBRW5jcnlwdC5zYWdl"),globals(),False)
sage.repl.load.load(sage.repl.load.base64.b64decode("UlNBRGVjcnlwdC5zYWdl"),globals(),False)
from math import *
import time

m = "1234567890123456789012345678901234567890123456789012345678901234567890"\
"1234567890123456789012345678901234567890123456789012345678901234567890"\
"1234567890123456789012345678901234567890123456789012345678901234567890"\
"1234567890123456789012345678901234567890123456789012345678901234567890"

m = long(m)

(p,q,e,d,n,phi_n) = keyGen()
print("private key:"+str(d))
c = RSAEncrypt(m,e,n)
print("cipher:"+str(c))

t1 = time.clock()
deM = RSADecrypt(c,d,p,q)
t2 = time.clock()
print("decrypt time(CRT):"+str(t2-t1))

t1 = time.clock()
deM = RSADecrypt2(c,d,n)
t2 = time.clock()
print("decrypt time(Nor):"+str(t2-t1))

print("decrypt:" + str(deM))
