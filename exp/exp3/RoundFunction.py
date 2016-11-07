from Permutation import *

def F_function(inBits,key):
	Bits1 = Expansion(inBits)
	Bits2 = KeyMixing(Bits1,key)
	Bits3 = SBox(Bits2)
	Bits4 = P32(Bits3)
	return Bits4

def RoundFunction((Lin,Rin),key):
	Lout = Rin
	Lnum = long(Lin,2)
	Fout = F_function(Rin,key)
	Fnum = long(Fout,2)
	Rnum = Lnum^Fnum
	Rout = Bin(Rnum,32)
	return (Lout,Rout)	