def dig(p):
	if(p.isalpha):
		p = p.lower()
		return ord(p)-ord('a')
def char(num):
	return chr(int(num)+ord('a'))

def HillEncrypt(key,m,R,fin,fout):
	i=0
	pnum = []
	pgroup=[]
	for line in fin:
		for p in line:
			if(p.isalpha()):
				pgroup.append(dig(p))
				i=(i+1)%m
				if(i==0):
					pnum.append(pgroup)
					pgroup = []
	if(i!=0):				#if len(p)%m!=0,then append 0 to the end of p
		while(i!=0):
			i=(i+1)%m
			pgroup.append(0)
		pnum.append(pgroup)
	c = matrix(R,pnum)*key;
	for cgroup in c:
		for cnum in cgroup:
			fout.write(char(cnum))

def HillDecrypt(key,m,R,fin,fout):
	i=0
	cnum = []
	cgroup=[]
	for line in fin:
		for c in line:
			if(c.isalpha()):
				cgroup.append(dig(c))
				i=(i+1)%m
				if(i==0):
					cnum.append(cgroup)
					cgroup = []
	if(i!=0):
		while(i!=0):
			i=(i+1)%m
			cgroup.append(0)
		cnum.append(cgroup)
	p = matrix(R,cnum)*(key^-1);
	for pgroup in p:
		for pnum in pgroup:
			fout.write(char(pnum))


fplant = open("text.txt",'r')
fdecrypt = open("HillDecrypt.txt",'w')

while(true):
	choose = raw_input("decrypt or encrypt? d/e:")
	if(choose == "d" or choose =="e"):
		break


R = IntegerModRing(26)
m = 4
key = matrix(R,[[19,12,17,13],[4,20,6,3],[19,13,7,5],[5,22,18,19]])
if(gcd(26,key.det())!=1):
	print("invalid key")
else:
	if(choose=="e"):
		fcipher = open("HillEncrypt.txt",'w')
		HillEncrypt(key,m,R,fplant,fcipher)
	else:
		fcipher = open("HillEncrypt.txt",'r')
		HillDecrypt(key,m,R,fcipher,fdecrypt)

fplant.close()
fdecrypt.close()
fcipher.close()