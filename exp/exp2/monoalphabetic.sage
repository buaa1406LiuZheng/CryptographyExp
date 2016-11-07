fkey = open("monoKey.txt",'r')
fin = open("text.txt",'r')
fout = open("monoEncrypt.txt",'w')

keylist = {}
for key in fkey:
	key = key.split()
	p = key[0]
	k = key[1]
	keylist[p]=k

for line in fin:
	for p in line:
		if(p.isalpha()):
			fout.write(keylist[p.lower()])
		else:
			fout.write(p)

fkey.close()
fin.close()
fout.close()