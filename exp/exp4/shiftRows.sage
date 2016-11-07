def shiftRows(Bytes32):
	newBytes32 = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(Bytes32[i][(j+i)%4])
		newBytes32.append(row)
	return newBytes32

def shiftRowsInverse(Bytes32):
	newBytes32 = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(Bytes32[i][(j-i)%4])
		newBytes32.append(row)
	return newBytes32