from DES import *
from KeyGenerate import *

keyList = getKey("0f1571c947d9e859")
hex_p = "02468aceeca86420"
print(DES(hex_p,keyList))