import geoip2.database
import requests
import bcrypt
import hashlib

import define
from config import get_config

def get_country_for_ip(ip):
   with geoip2.database.Reader(define.GEOIP2_DB_PATH) as reader:
      try:
         return reader.country(ip).country.iso_code
      except geoip2.errors.AddressNotFoundError:
         pass
      except geoip2.errors.GeoIP2Error as err:
         print(f"Unexpected {err=} while resolving country code for {ip=}")
         pass
   return None

def request_ip(request):
   return request.remote_addr

def chunked(size, source):
   for i in range(0, len(source), size):
      yield source[i:i+size]

def forward_request(request, url):
   return requests.get(url, headers={"miHoYoCloudClientIP": request_ip(request)}).content

def password_hash(password):
   h = hashlib.new('sha256')
   h.update(password.encode())
   return bcrypt.hashpw(h.hexdigest().encode(), bcrypt.gensalt(rounds=get_config()["security"]["bcrypt_cost"]))

def password_verify(password, hashed):
   h = hashlib.new('sha256')
   h.update(password.encode())
   return bcrypt.checkpw(h.hexdigest().encode(), hashed)

def mask_string(text):
   if len(text) < 4:
      return "*" * len(text) # if source is below 4 characters, mask it in entirety
   else:
      start_pos = 2 if len(text) >= 10 else 1 # uncover either 1 or 2 first characters, depending on total length
      end_post = 2 if len(text) > 5 else 1 # uncover 2 last characters, but only if total length is above 5
      return f"{text[0:start_pos]}****{text[len(text)-end_post:]}"

def mask_email(email):
   text = email.split('@')
   return f"{mask_string(text[0])}@{text[1]}"