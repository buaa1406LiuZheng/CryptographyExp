def Bin(i,*WIDTH):
    s = bin(i)
    if(s[0:2]=="0b"):
        s=s[2:]
    if(s[len(s)-1]=="L"):
        s = s[0:len(s)-1]
    if(len(WIDTH)==0):
        return s
    else:
        return "0"*(WIDTH[0]-len(s))+s
def Hex(i,*WIDTH):
    s = hex(i)
    if(s[0:2]=="0x"):
        s = s[2:]
    if(s[len(s)-1]=="L"):
        s = s[0:len(s)-1]
    if(len(WIDTH)==0):
        return s
    else:
        return "0"*(WIDTH[0]-len(s))+s
def spiltByWidth(string,width):
    return [string[x:x+width] for x in range(0,len(string),width)]
def Not(b1,WIDTH=32):
    one = '1'*WIDTH
    one = int(one,2)
    b1 = b1^^one
    return b1
def leftRotate(n,shamt,WIDTH=32):
    s = Bin(n,WIDTH)
    return long(s[shamt:]+s[0:shamt],2)

def Padding(mHex):
    #add padding
    mlen = len(mHex)*4
    if(mHex==""):
        mBin=""
    else:
        mBin = Bin(long(mHex,16),mlen)
    mPaddingBin = "1"
    count = mlen+1
    while((count%512!=448)):
        mPaddingBin+="0"
        count+=1
    mPaddingBin = mBin+mPaddingBin
    mlenBin = Bin(mlen,64)
    mBin = mPaddingBin+mlenBin
    return mBin

def ExtendW(block):
    w = spiltByWidth(block,32)
    for i in range(0,16):
        w[i] = long(w[i],2)
    for i in range(16,80):
        wi = w[i-3] ^^ w[i-8] ^^ w[i-14] ^^ w[i-16]
        wi = leftRotate(wi,1)
        w.append(wi)
    return w

def fFunction(h0,h1,h2,h3,h4,block):

    #Extend the first 16 words into the remaining 48 words w[16..63] of the message schedule array:
    w = ExtendW(block)

    #Initialize hash value for this block:
    a = h0
    b = h1
    c = h2
    d = h3
    e = h4

    #Main loop:
    for i in range(0,80):
        if (i<20):
            f = (b & c) | (Not(b) & d) #(b and c) or ((not b) and d)
            k = 0x5A827999
        elif(i<40):
            f = b ^^ c ^^ d #b xor c xor d
            k = 0x6ED9EBA1
        elif(i<60):
            f = (b & c) | (b & d) | (c & d) #(b and c) or (b and d) or (c and d) 
            k = 0x8F1BBCDC
        else:
            f = b ^^ c ^^ d #b xor c xor d
            k = 0xCA62C1D6

        temp = (leftRotate(a,5) + f + e + k + w[i])%(1<<32)
        e = d
        d = c
        c = leftRotate(b,30)
        b = a
        a = temp

    #Add this block's hash to result so far:
    h0 = (h0 + a)%(1<<32)
    h1 = (h1 + b)%(1<<32)
    h2 = (h2 + c)%(1<<32)
    h3 = (h3 + d)%(1<<32)
    h4 = (h4 + e)%(1<<32)
    return (h0,h1,h2,h3,h4)

def SHA1(mHex, IV=(0x67452301,0xEFCDAB89,0x98BADCFE,0x10325476,0xC3D2E1F0)):
    #Initialize variables:
    h0 = IV[0]
    h1 = IV[1]
    h2 = IV[2]
    h3 = IV[3]
    h4 = IV[4]

    #Pre-processing:
    mBin = Padding(mHex)
    M = spiltByWidth(mBin,512)

    for block in M:
        (h0,h1,h2,h3,h4) = fFunction(h0,h1,h2,h3,h4,block)

    h0 = Hex(h0,8)
    h1 = Hex(h1,8)
    h2 = Hex(h2,8)
    h3 = Hex(h3,8)
    h4 = Hex(h4,8)

    return h0+h1+h2+h3+h4