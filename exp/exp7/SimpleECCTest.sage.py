# This file was *autogenerated* from the file SimpleECCTest.sage
from sage.all_cmdline import *   # import sage library
_sage_const_1 = Integer(1); _sage_const_0 = Integer(0); _sage_const_386 = Integer(386); _sage_const_5 = Integer(5); _sage_const_188 = Integer(188); _sage_const_376 = Integer(376); _sage_const_201 = Integer(201); _sage_const_751 = Integer(751); _sage_const_562 = Integer(562)
sage.repl.load.load(sage.repl.load.base64.b64decode("c2ltcGxlRUNDLnNhZ2U="),globals(),False)

R = IntegerModRing(_sage_const_751 )
E = EllipticCurve(R,[-_sage_const_1 ,_sage_const_188 ])
G = E(_sage_const_0 ,_sage_const_376 )
order = E.order()
Pm = E(_sage_const_562 ,_sage_const_201 )
k=_sage_const_386 
Pb = E(_sage_const_201 ,_sage_const_5 )
Cm = EncryptTest(Pm,E,G,Pb,k)
print(Cm[_sage_const_0 ].xy(),Cm[_sage_const_1 ].xy())

(E,G,nA,PA) = keyGen()
Pm = E.random_point()
Cm = Encrypt(Pm,E,G,PA)
print(Decrypt(Cm,E,nA) == Pm)