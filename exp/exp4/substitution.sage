mulMatrixList = \
[[1,0,0,0,1,1,1,1],
[1,1,0,0,0,1,1,1],
[1,1,1,0,0,0,1,1],
[1,1,1,1,0,0,0,1],
[1,1,1,1,1,0,0,0],
[0,1,1,1,1,1,0,0],
[0,0,1,1,1,1,1,0],
[0,0,0,1,1,1,1,1]
]
addVectorList = [1,1,0,0,0,1,1,0]

R=GF(2^8,name = "x",modulus = x^8+x^4+x^3+x+1)

sbox = []
for byteNum in range(0,256):
	poly = R.fetch_int(byteNum)
	if(poly==0):
		polyInverse = R(0)
	else:
		polyInverse = poly^-1
	inverseNum = polyInverse.integer_representation()

	vector = Matrix(IntegerModRing(2),[R.vector_space()[inverseNum]]).transpose()
	addVector = Matrix(IntegerModRing(2),[addVectorList]).transpose()
	mulMatrix = Matrix(IntegerModRing(2),mulMatrixList)

	outVector = mulMatrix*vector+addVector
	outList = list(outVector)
	outNum = 0
	for i in range(0,len(outList)):
		if(outList[i][0]==1):
			outNum+=1<<i
	sbox.append(outNum)

sboxInverse = []
for byteNum in range(0,256):
	vector = Matrix(IntegerModRing(2),[R.vector_space()[byteNum]]).transpose()
	addVector = Matrix(IntegerModRing(2),[addVectorList]).transpose()
	mulMatrix = Matrix(IntegerModRing(2),mulMatrixList).inverse()

	polyVector = mulMatrix*(vector-addVector)
	polyList = list(polyVector)
	polyNum = 0
	for i in range(0,len(polyList)):
		if(polyList[i][0]==1):
			polyNum+=1<<i

	poly = R.fetch_int(polyNum)
	if(poly==0):
		polyInverse = R(0)
	else:
		polyInverse = poly^-1
	inverseNum = polyInverse.integer_representation()
	sboxInverse.append(inverseNum)

#single byte sbox
def ByteSBox(byteNum):
	return sbox[byteNum]

#single byte sboxInverse
def ByteSBoxInverse(byteNum):
	return sboxInverse[byteNum]

#32Bytes substitution(sbox)
def BytesSubstitution(Bytes32):
	newBytes32 = []
	for word in Bytes32:
		newWord = []
		for byte in word:
			newWord.append(ByteSBox(byte))
		newBytes32.append(newWord)
	return newBytes32

#32Bytes substitution Inverse(sboxInverse)
def BytesSubstitutionInverse(Bytes32):
	newBytes32 = []
	for word in Bytes32:
		newWord = []
		for byte in word:
			newWord.append(ByteSBoxInverse(byte))
		newBytes32.append(newWord)
	return newBytes32
