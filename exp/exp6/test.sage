load SHA1.sage
load HMAC.sage
import hashlib
import hmac
from binascii import *

print("test SHA1:")
a = "liuzheng"
print("my sha1:"+SHA1(b2a_hex(a)))
print("py sha1:"+hashlib.sha1(a).hexdigest())

print("test HMAC")
key = "This is my key"
m = "hello world!!!!!!!!!!!!!!!"
print("my hmac:"+HMAC(b2a_hex(key), b2a_hex(m)))
h = hmac.new(key,m,hashlib.sha1)
print("py hmac:"+h.hexdigest())