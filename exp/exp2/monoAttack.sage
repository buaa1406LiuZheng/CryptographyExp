from WordMatch import*

fin = open("monoEncrypt.txt",'r')
fout = open("monoDecrypt.txt",'w')

#alphabet statistical frequency
alphaFrequency = ['e','t','a','o','i','n','s','h','r','d','l','c','u','m','w','f','g','y','p','b','v','k','j','x','q','z']

#count the frequency of the letter in cipher
alphabetCount = {}
for line in fin:
	for c in line:
		if(c.isalpha()):
			c = c.lower()
			if(c in alphabetCount):
				alphabetCount[c]+=1
			else:
				alphabetCount[c]=1


sortedCount = sorted(alphabetCount.iteritems(), key=lambda x: x[1] , reverse=1)
sortedAlpha = [item[0] for item in sortedCount]

fin.seek(0)		#file pointer back to the head of the file
decrytp = ""

for line in fin:
	for c in line:
		if(c.isalpha()):
			c = c.lower()
			position = sortedAlpha.index(c)
			decrytp+= alphaFrequency[position]
		else:
			decrytp+=c

keyWord = ["the","a","and","to","of","were","was"]
print("input keyword,enter ';' to end:")
while(true):
	word = raw_input()
	if(word == ";"):
		break
	keyWord.append(word)

print(keyWord)
#decrytp = Match(decrytp,"the")
for word in keyWord:
	decrytp = Match(decrytp,word)

fout.write(decrytp)

fin.close()
fout.close()