from Permutation import *

#get 56bits key seed
def keyInitial(keyHex):
	keyNum = long(keyHex,16)
	key = Bin(keyNum,64)
	key = PC1(key)
	return key

#shift left two parts of kys
def ShiftLeft(key,shamt):
	lenth = 28
	keyGroup = spiltByWidth(key,lenth)
	keyGroup[0] = keyGroup[0][shamt:]+keyGroup[0][0:shamt]
	keyGroup[1] = keyGroup[1][shamt:]+keyGroup[1][0:shamt]
	key = keyGroup[0]+keyGroup[1]
	return key

#get KeyList(K1-K16)
def getKey(keyHex):
	keyList = []
	key = keyInitial(keyHex)
	shiftAmount = [1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1]
	for shamt in shiftAmount:
		key = ShiftLeft(key,shamt)
		keyList.append(PC2(key))
	return keyList