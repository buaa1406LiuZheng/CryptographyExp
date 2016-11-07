load RSA_OAEP.sage
load keyGen.sage
import binascii

plaintext = "1234567890abcdeffedbca09876543211234567890abcdeffedbca0987654321"\
			"1234567890abcdeffedbca09876543211234567890abcdeffedbca098765"
(p,q,e,d,n,phi_n) = keyGen()
c = RSA_OAEP_Encrypt(plaintext,(e,n))
print("encrypt:"+c)
m = RSA_OAEP_Decrypt(c,(d,p,q))
print("decrypt:"+m)

plaintext = binascii.b2a_hex("helloworldhelloworldhelloworldhelloworldhelloworldhelloworld12")
(p,q,e,d,n,phi_n) = keyGen()
c = RSA_OAEP_Encrypt(plaintext,(e,n))
print("encrypt:"+c)
m = RSA_OAEP_Decrypt(c,(d,p,q))
decrypt = binascii.a2b_hex(m)
print("decrypt:"+decrypt)