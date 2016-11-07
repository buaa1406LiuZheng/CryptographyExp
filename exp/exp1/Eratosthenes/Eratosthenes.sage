def Eratosthenes(n):
	numList = [0]*(n+1)
	i=3
	while(i*i<=n):
		if(numList[i]==0):
			j=2*i
			while(j<n):
				numList[j]=1
				j+=i
		i=i+2
	cnt=1
	fout.write("2 ")
	for i in range(3,n+1,2):
		if(numList[i]==0):
			fout.write(str(i)+' ')
			cnt=cnt+1
			if((cnt%10)==0):
				fout.write('\n')
	fout.write("\ntotal:"+str(cnt))
	return

fout=open("output.txt","w")

n=int(input("input a num:\n"))
Eratosthenes(n)

fout.close()