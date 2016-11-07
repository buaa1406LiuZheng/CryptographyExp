f = open("monoKey.txt",'w')

key = "liuzheng"
keylist=[]
p = ord('a')
for c in key:
	cp = chr(p)
	if(c not in keylist):
		f.write(cp+' '+c+'\n')
		p=p+1
		keylist.append(c)

for c in range(ord('a'),ord('z')+1):
	cp = chr(p)
	c = chr(c)
	if(c not in keylist):
		f.write(cp+' '+c+'\n')
		p=p+1
		keylist.append(c)

f.close()