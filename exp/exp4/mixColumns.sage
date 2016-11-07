mixMatrixList = \
[[2,3,1,1],
[1,2,3,1,],
[1,1,2,3],
[3,1,1,2]]

mixMatrixListInverse = \
[[14,11,13,9],
[9,14,11,13],
[13,9,14,11],
[11,13,9,14]]

def mixColumns(Bytes32):
	R=GF(2^8,name = "x",modulus = x^8+x^4+x^3+x+1)
	Bytes32GF = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(R.fetch_int(Bytes32[i][j]))
		Bytes32GF.append(row)
	

	mixMatrixListGF = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(R.fetch_int(mixMatrixList[i][j]))
		mixMatrixListGF.append(row)

	BytesMatrix = Matrix(R,Bytes32GF)
	mixMatrix = Matrix(R,mixMatrixListGF)
	outMatrix = mixMatrix*BytesMatrix

	outList = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(outMatrix[i][j].integer_representation())
		outList.append(row)
	return outList

def mixColumnsInverse(Bytes32):
	R=GF(2^8,name = "x",modulus = x^8+x^4+x^3+x+1)
	Bytes32GF = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(R.fetch_int(Bytes32[i][j]))
		Bytes32GF.append(row)
	

	mixMatrixListInverseGF = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(R.fetch_int(mixMatrixListInverse[i][j]))
		mixMatrixListInverseGF.append(row)

	BytesMatrix = Matrix(R,Bytes32GF)
	mixMatrix = Matrix(R,mixMatrixListInverseGF)
	outMatrix = mixMatrix*BytesMatrix

	outList = []
	for i in range(0,4):		#row i
		row = []
		for j in range(0,4): 	#column j
			row.append(outMatrix[i][j].integer_representation())
		outList.append(row)
	return outList