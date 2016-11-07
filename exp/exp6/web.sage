load SHA1.sage
from binascii import *
import time
import os
from os.path import *
from shutil import *

root = os.getcwd()
webdir = root+"/webdir/"
backup = root+"/backup/"
backupInfo = dict();

def scan():
	for parent,dirnames,filenames in os.walk(webdir):
		for filename in filenames:

			if(filename[0]=='.'):	#hidden file
				continue

			relativePath = join(relpath(parent,webdir),filename)

			if(relativePath not in backupInfo):
				#this file is not exist in backup, delete it
				os.remove(join(webdir,relativePath))
			else:
				filePath = join(webdir,relativePath)
				file = open(filePath,'r')
				content = file.read()
				hashValue = SHA1(b2a_hex(content))
				file.close()

				#compare hash value
				if(hashValue!=backupInfo[relativePath]):
					copyfile(backupPath,filePath)

#initial
for parent,dirnames,filenames in os.walk(webdir):
	for dirname in  dirnames:
		#if is a directory, create a directory
		relativePath = join(relpath(parent,webdir),dirname)
		backupPath = realpath(join(backup,relativePath))

		if(not exists(backupPath)):
			os.mkdir(backupPath)
	for filename in filenames:
		if(filename[0]=='.'):	#hidden file
			continue
		#if is a file, copy that file and add the file path to backupInfo
		relativePath = join(relpath(parent,webdir),filename)
		backupPath = realpath(join(backup,relativePath))

		copyfile(join(webdir,relativePath),backupPath)

		#calculate the hash value
		backupFile = open(backupPath,'r')
		backupContent = backupFile.read()
		backupHashValue = SHA1(b2a_hex(backupContent))
		backupFile.close()
		backupInfo[relativePath] = backupHashValue
print(backupInfo.keys())

#scan
while(True):
	scan()
	print("scaning")
	time.sleep(1)	#interval is 1s