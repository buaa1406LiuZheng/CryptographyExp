load ibe.sage

(p,q,P,Ppub,s) = Setup()
print("setup done")
ID = "LiuZheng"
dID = Extract(ID,p,q,s)
print("extract done")
M = 987654321234567890987654321234567890987654321234567890987654321234567890987654321234567890987654321234567890
C = Encrypt(p,q,P,Ppub,ID,M)
print(C)
MDe = Decrypt(p,q,C,dID,P)
print(MDe==M)

C = (C[0],C[1]+1,C[2])
try:
	Mwrong = Decrypt(p,q,C,dID,P)
except Exception, e:
	print(e)
else:
	print(Mwrong)
