load SHA256v2.sage

def I2OSP(x,xlen):
	return Hex(x,xlen)

def OS2IP(x):
	return long(x,16)