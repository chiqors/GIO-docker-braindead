import rsa
from base64 import b64encode, b64decode

from config import get_config
import utils

def decrypt_sdk_authkey(version, message):
   return rsa.decrypt(b64decode(message), rsa.PublicKey.load_pkcs1(get_config()["crypto"]["rsa"]["authkey"][version])).decode()

def decrypt_rsa_password(message):
   return rsa.decrypt(b64decode(message), rsa.PrivateKey.load_pkcs1(get_config()["crypto"]["rsa"]["password"])).decode()