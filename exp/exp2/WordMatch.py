import re

fixLetter = ['e','t']

def Pattern(word):
	wordPlace=[]
	replaceList=[]
	pattern = "\\b"
	for i in range(0,len(word)):
		c=word[i]
		if(c not in fixLetter):
			wordPlace.append(i)
			replaceList.append(c)
			pattern+="\w"
		else:
			pattern+=c
	pattern+="\\b"
	return wordPlace,replaceList,pattern

#find the most probably letter to replace
def findMax(matchResult,wordPlace):
	count = {}
	for word in matchResult:
		s = ""
		for place in wordPlace:
			s+=word[place]
		if(s in count):
			count[s]+=1
		else:
			count[s]=1
	sortedCount = sorted(count.iteritems(), key=lambda x: x[1] , reverse=1)
	return sortedCount

#replace substitude by replaceChar
def Replace(text,replaceList,replaceList2):
	replaceText = ""
	for c in text:
		if(c in replaceList2):
			replaceLetter=replaceList[replaceList2.index(c)]
			replaceText+=replaceLetter 
		elif(c in replaceList):
			replaceLetter=replaceList2[replaceList.index(c)]
			while(replaceLetter in replaceList and replaceLetter!=c):
				replaceLetter = replaceList2[replaceList.index(replaceLetter)]
			if(replaceLetter == c):
				replaceLetter = replaceList[replaceList2.index(c)]
			replaceText+=replaceLetter
		else:
			replaceText+=c
	return replaceText
def Match(text,word):
	wordPlace,replaceList,pattern = Pattern(word)
	if(len(replaceList)==0 or (len(word)!=1 and len(replaceList)==len(word))):
		return text
	matchResult = re.findall(pattern,text)
	if(len(matchResult)==0):
		return text

	sortedCount = findMax(matchResult,wordPlace)

	for i in range(0,len(sortedCount)):
		for j in range(0,len(fixLetter)):
			if(fixLetter[j] in sortedCount[i][0]):
				break
		if(j==len(fixLetter)-1):
			break
	if(i==len(sortedCount)):
		return text

	replaceWord = sortedCount[i][0]
	replaceList2 = []
	for i in range(0,len(replaceList)):
		replaceList2.append(replaceWord[i])
		if(replaceList[i] not in fixLetter):
			fixLetter.append(replaceList[i])
	replaceText = Replace(text,replaceList,replaceList2)
	return replaceText