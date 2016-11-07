load substitution.sage
load shiftRows.sage
load mixColumns.sage
load addRoundKey.sage
load keyExpansion.sage

def Hex(i,WIDTH):
	s = hex(i)
	return "0"*(WIDTH-len(s))+s
def spiltByWidth(string,width):
	return [string[x:x+width] for x in range(0,len(string),width)]
def oneRound(Bytes32,roundKey1,roundKey2):
	Bytes32 = addRoundKey(Bytes32,roundKey1)
	Bytes32 = BytesSubstitution(Bytes32)
	Bytes32 = shiftRows(Bytes32)
	Bytes32 = mixColumns(Bytes32)
	Bytes32 = addRoundKey(Bytes32,roundKey2)
	return Bytes32
def Xor(p1,p2):
	XorMatrix = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(p1Matrix[i][j]^^p2Matrix[i][j])
		XorMatrix.append(row)
	return XorMatrix

p1 = "0123456789abcdeffedcba9876543210"
p2 = "9012bcd9010f703109f78130f09a09b9"
key ="0f1571c947d9e8590cb7add6af7f6798"

t1Group = spiltByWidth(p1,2)
t2Group = spiltByWidth(p2,2)
keyGroup = spiltByWidth(key,2)
for i in range(0,16):
	t1Group[i] = int(t1Group[i],16)
	t2Group[i] = int(t2Group[i],16)
	keyGroup[i] = int(keyGroup[i],16)
keyMatrix = []
for i in range(0,4):		#row i
	row = []
	for j in range(0,4): 	#column j
		row.append(keyGroup[i+4*j])
	keyMatrix.append(row)
keyList = getKey(keyMatrix)
k0 = keyList[0]
k1 = keyList[1]
p1Matrix = []
for i in range(0,4):		#row i
	row = []
	for j in range(0,4): 	#column j
		row.append(t1Group[i+4*j])
	p1Matrix.append(row)
p2Matrix = []
for i in range(0,4):		#row i
	row = []
	for j in range(0,4): 	#column j
		row.append(t2Group[i+4*j])
	p2Matrix.append(row)

print(Xor(shiftRows(p1Matrix),shiftRows(p2Matrix)))
print(shiftRows(Xor(p1Matrix,p2Matrix)))
#c1Matrix = oneRound(p1Matrix,k0,k1)
#c2Matrix = oneRound(p2Matrix,k0,k1)
#XorP = Xor(p1Matrix,p2Matrix)
#XorC = Xor(c1Matrix,c2Matrix)
#XorC = mixColumnsInverse(XorC)
#XorC = shiftRowsInverse(XorC)
#print(Xor(mixColumnsInverse(c1Matrix),mixColumnsInverse(c2Matrix)))
##print(XorC)
#print(Xor(addRoundKey(BytesSubstitution(p1Matrix),k0),addRoundKey(BytesSubstitution(p2Matrix),k0)))
