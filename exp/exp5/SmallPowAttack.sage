load keyGen.sage
load RSAEncrypt.sage
load SmallPow.sage

m = "1234567890123456789012345678901234567890123456789012345678901234567890"\
"1234567890123456789012345678901234567890123456789012345678901234567890"\
"1234567890123456789012345678901234567890123456789012345678901234567890"\
"1234567890123456789012345678901234567890123456789012345678901234567890"
m = long(m)

#(p1,q1,e1,d1,n1,phi_n1) = keyGen(3)
#(p2,q2,e2,d2,n2,phi_n2) = keyGen(3)
#(p3,q3,e3,d3,n3,phi_n3) = keyGen(3)
#c1 = RSAEncrypt(m,e1,n1)
#c2 = RSAEncrypt(m,e2,n2)
#c3 = RSAEncrypt(m,e3,n3)

cgroup = []
ngroup = []
e = 17
for i in range(0,e):
	(p,q,eGet,d,n,phi_n) = keyGen(e)
	ngroup.append(n)
	cipher = RSAEncrypt(m,e,n)
	cgroup.append(cipher)

mAttack = smallPow_fixE(cgroup,ngroup,e)
print("e="+str(e)+":"+str(mAttack))