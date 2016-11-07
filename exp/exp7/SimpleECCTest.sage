load simpleECC.sage

R = IntegerModRing(751)
E = EllipticCurve(R,[-1,188])
G = E(0,376)
order = E.order()
Pm = E(562,201)
k=386
Pb = E(201,5)
Cm = EncryptTest(Pm,E,G,Pb,k)
print(Cm[0].xy(),Cm[1].xy())

(E,G,nA,PA) = keyGen()
Pm = E.random_point()
Cm = Encrypt(Pm,E,G,PA)
print(Decrypt(Cm,E,nA) == Pm)