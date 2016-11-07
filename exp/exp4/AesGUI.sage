from Tkinter import *
load AesCBC.sage

def doAES():
	finpath = finEntry.get()
	foutpath = foutEntry.get()
	try:
		fin = open(finpath,'r')
		fout = open(foutpath,'w')
	except Exception, e:
		print("can't open file")
		return
	mode = select.get()
	IV = IVEntry.get()
	key = keyEntry.get()
	AesCBC(fin,fout,mode,IV,key)
	return

root = Tk()
root.title("AesCBC")
root.geometry('500x250')

#Fin
FinFrame = Frame(root,bd = 5)
FinFrame.pack()
Label( FinFrame, text="fin", width = 10).pack(side = LEFT)
finEntry = Entry(FinFrame, width = 40, bd = 5)
finEntry.insert(0,"text.txt")
finEntry.pack(side = LEFT)
#Fout
FoutFrame = Frame(root,bd = 5)
FoutFrame.pack()
Label( FoutFrame, text="fout", width = 10).pack(side = LEFT)
foutEntry = Entry(FoutFrame, width = 40, bd = 5)
foutEntry.insert(0,"encrypt.txt")
foutEntry.pack(side = LEFT)
#IV
IVFrame = Frame(root,bd = 5)
IVFrame.pack()
Label( IVFrame, text="IV", width = 10).pack(side = LEFT)
IVEntry = Entry(IVFrame, width = 40, bd = 5)
IVEntry.insert(0,"0123456789abcdeffedcba987654325")
IVEntry.pack(side = LEFT)
#Key
KeyFrame = Frame(root,bd = 5)
KeyFrame.pack()
Label( KeyFrame, text="key", width = 10).pack(side = LEFT)
keyEntry = Entry(KeyFrame, width = 40, bd = 5)
keyEntry.insert(0,"0f1571c947d9e8590cb7add6af7f6798")
keyEntry.pack(side = LEFT)
#mode select
modeFrame = Frame(root,bd = 5)
modeFrame.pack()
select = StringVar()
EncryptButton = Radiobutton(modeFrame, text="Encrypt", variable=select, value="e")
DecryptButton = Radiobutton(modeFrame, text="Decrypt", variable=select, value="d")
EncryptButton.pack(side = LEFT)
DecryptButton.pack(side = LEFT)
#confirm Button
buttonFrame = Frame(root,bd = 5)
buttonFrame.pack()
confirmButton = Button( buttonFrame, text = "Confirm", command = doAES)
confirmButton.pack()

root.mainloop()