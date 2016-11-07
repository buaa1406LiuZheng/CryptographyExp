load substitution.sage
load shiftRows.sage
load mixColumns.sage
load addRoundKey.sage

def EncryptRound(Bytes32,roundKey):
	Bytes32 = BytesSubstitution(Bytes32)
	Bytes32 = shiftRows(Bytes32)
	Bytes32 = mixColumns(Bytes32)
	Bytes32 = addRoundKey(Bytes32,roundKey)
	return Bytes32

def EncryptRound10(Bytes32,roundKey):
	Bytes32 = BytesSubstitution(Bytes32)
	Bytes32 = shiftRows(Bytes32)
	Bytes32 = addRoundKey(Bytes32,roundKey)
	return Bytes32

def DecryptRound(Bytes32,roundKey):
	Bytes32 = shiftRowsInverse(Bytes32)
	Bytes32 = BytesSubstitutionInverse(Bytes32)
	Bytes32 = addRoundKey(Bytes32,roundKey)
	Bytes32 = mixColumnsInverse(Bytes32)
	return Bytes32

def DecryptRound10(Bytes32,roundKey):
	Bytes32 = shiftRowsInverse(Bytes32)
	Bytes32 = BytesSubstitutionInverse(Bytes32)
	Bytes32 = addRoundKey(Bytes32,roundKey)
	return Bytes32

def debug(Bytes32):
	outByte = []
	for i in range(0,4):
		row = []
		for j in range(0,4):
			row.append(hex(Bytes32[i][j]))
		outByte.append(row)
	print(outByte)
