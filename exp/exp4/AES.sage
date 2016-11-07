load AESRound.sage
load keyExpansion.sage

def AESEncrypt(plaintext,key):

	Bytes32 = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(plaintext[i+4*j])
		Bytes32.append(row)

	keyMatrix = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(key[i+4*j])
		keyMatrix.append(row)

	keyList = getKey(keyMatrix)
	Bytes32 = addRoundKey(Bytes32,keyList[0])
	for i in range(1,10):
		Bytes32 = EncryptRound(Bytes32,keyList[i])
	Bytes32 = EncryptRound10(Bytes32,keyList[10])

	outList = []
	for j in range(0,4):		#column j
		for i in range(0,4): 	#row i
			outList.append(Bytes32[i][j])
	return outList

def AESDecrypt(plaintext,key):

	Bytes32 = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(plaintext[i+4*j])
		Bytes32.append(row)

	keyMatrix = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(key[i+4*j])
		keyMatrix.append(row)

	keyList = getKey(keyMatrix)
	keyList.reverse()
	Bytes32 = addRoundKey(Bytes32,keyList[0])
	for i in range(1,10):
		Bytes32 = DecryptRound(Bytes32,keyList[i])
	Bytes32 = DecryptRound10(Bytes32,keyList[10])

	outList = []
	for j in range(0,4):		#column j
		for i in range(0,4): 	#row i
			outList.append(Bytes32[i][j])

	return outList