load keyGen.sage
load RSAEncrypt.sage
load RSADecrypt.sage
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