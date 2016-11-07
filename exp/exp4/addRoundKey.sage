def addRoundKey(Bytes32,roundKey):
	for i in range(0,4):
		for j in range(0,4):
			Bytes32[i][j] = Bytes32[i][j] ^^ roundKey[i][j]
	return Bytes32
