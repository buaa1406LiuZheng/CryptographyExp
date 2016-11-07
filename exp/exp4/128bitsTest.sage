load AES.sage
load keyExpansion.sage
load substitution.sage

def Hex(i,WIDTH):
	s = hex(i)
	return "0"*(WIDTH-len(s))+s
def spiltByWidth(string,width):
	return [string[x:x+width] for x in range(0,len(string),width)]

plaintext = "0123456789abcdeffedcba9876543210"
key = 		"0f1571c947d9e8590cb7add6af7f6798"
cipher = 	"ff0b844a0853bf7c6934ab4364148fb9"

textGroup = spiltByWidth(plaintext,2)
keyGroup = spiltByWidth(key,2)
for i in range(0,16):
	textGroup[i] = int(textGroup[i],16)
	keyGroup[i] = int(keyGroup[i],16)

outGroup = AESEncrypt(textGroup,keyGroup)
#print(outGroup)
out = ""
for i in range(0,16):
	outGroup[i] = Hex(outGroup[i],2)
	out+=outGroup[i]
print(outGroup)
print(out)