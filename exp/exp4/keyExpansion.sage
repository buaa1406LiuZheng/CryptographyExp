load substitution.sage

def getNextKey(keyList,Round):

	#get 4 key words
	keyWords = []
	for j in range(0,4):		#colunm
		word = []
		for i in range(0,4):	#row
			word.append(keyList[i][j])
		keyWords.append(word)

	#gFunction
	g3 = gFunction(keyWords[3],Round)

	#get new 4 key words
	newKeyWords = [[],[],[],[]]
	for j in range(0,4):
		newKeyWords[0].append(g3[j] ^^ keyWords[0][j])
	for i in range(1,4):
		for j in range (0,4):
			newKeyWords[i].append(newKeyWords[i-1][j] ^^ keyWords[i][j])

	#transpose newKeyWords
	newKeyList  = []	
	for j in range(0,4):		#colunm
		row = []
		for i in range(0,4):	#row
			row.append(newKeyWords[i][j])
		newKeyList.append(row)
	return newKeyList

def gFunction(keyWord,Round):
	RC = [1,2,4,8,16,32,64,128,27,54]
	newWord = []
	for i in range(0,4):
		newWord.append(ByteSBox(keyWord[(i+1)%4]))
	newWord[0] = newWord[0]^^RC[Round]
	Round+=1
	return newWord

def getKey(key):
	keyList = []
	keyList.append(key)
	for i in range(0,10):
		key = getNextKey(key,i)
		keyList.append(key)
	return keyList