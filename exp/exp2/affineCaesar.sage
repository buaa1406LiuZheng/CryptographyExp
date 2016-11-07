
n=26
R = IntegerModRing(n)

def encrypt(a,b,p):
	if(gcd(a,n)==1): 			#make sure key 'a' is invertible
		return R(a*p+b)
	else:
		print("invalid key")
		return -1

def decrypt(a,b,c):
	if(gcd(a,n)==1):
		return R((c-b)*a^-1)
	else:
		print("invalid key")
		return -1

def dig(p):
	p = p.lower()
	return ord(p)-ord('a')
def char(num):
	return chr(int(num)+ord('a'))

a = 15
b = 9

while(true):
	choose = raw_input("decrypt or encrypt? d/e:")
	if(choose == "d" or choose =="e"):
		break

if(choose == "e"):
	fin = open("text.txt",'r')
	fout = open("Caesar.txt",'w')
	for line in fin:
		for p in line:
			if(p.isalpha()):
				num = encrypt(a,b,dig(p))
				fout.write(char(int(num)))
			else:
				fout.write(p)
elif(choose == "d"):
	fin = open("Caesar.txt",'r')
	fout = open("CaesarDecrypt.txt",'w')
	for line in fin:
		for p in line:
			if(p.isalpha()):
				num = decrypt(a,b,dig(p))
				fout.write(char(int(num)))
			else:
				fout.write(p)

fin.close()
fout.close()