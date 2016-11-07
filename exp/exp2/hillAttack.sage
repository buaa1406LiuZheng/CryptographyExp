import random

def dig(p):
	if(p.isalpha):
		p = p.lower()
		return ord(p)-ord('a')


fplant = open("HillDecrypt.txt",'r')
fcipher = open("HillEncrypt.txt",'r')
R = IntegerModRing(26)

text = fplant.readline(30000)
ctext = fcipher.readline(30000)
lenth = len(text)
m=4

pnum = []
record = []
while(true):
	for i in range(0,m):
		i = random.randint(0,lenth//m-1)
		record.append(i)
		pgroup=[]
		for j in range(0,m):
			pgroup.append(dig(text[m*i+j]))
		pnum.append(pgroup)
	p = matrix(R,pnum)
	if(gcd(p.det(),26)!=1):
		pnum=[]
		record = []
	else:
		break

cnum = []
for i in record:
	cgroup = []
	for j in range(0,m):
		cgroup.append(dig(ctext[m*i+j]))
	cnum.append(cgroup)

c = matrix(R,cnum)

key = (p^-1)*c
print(key)

fcipher.close()
fplant.close()