from __main__ import app

from flask import Response, request, abort, render_template, flash
import random
import string
import json
import re
from time import time as epoch

from response import json_rsp, json_rsp_with_msg
from database import get_db
from utils import forward_request, request_ip, get_country_for_ip, password_hash, password_verify, mask_string, mask_email
import define
from config import get_config

# global dispatch
@app.route('/query_region_list', methods = ['GET'])
def query_region_list():
   try:
      return forward_request(request, f"{get_config()['dispatch']['global']}/query_region_list?{request.query_string.decode()}")
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while forwarding request")
      abort(500)


# local dispatch
@app.route('/query_region/<name>', methods = ['GET'])
def query_cur_region(name):
   try:
      return forward_request(request, f"{get_config()['dispatch']['local'][name]}/query_cur_region?{request.query_string.decode()}")
   except KeyError:
      print(f"Attempting to query unknown region name={name}")
      abort(404)
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while forwarding request")
      abort(500)


# sdk account
@app.route('/sdk/login', methods = ['GET'])
def sdk_login():
   try:
      cursor = get_db().cursor()

      user = cursor.execute("SELECT * FROM `accounts` WHERE `name` = ?", (request.args.get("account"),)).fetchone()
      if not user:
         return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Incorrect username or password.", {})

      if not password_verify(request.args.get("password"), user["password"]):
         return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Incorrect username or password.", {})

      token = ''.join(random.choice(string.ascii_letters) for i in range(get_config()["security"]["token_length"]))
      cursor.execute(
         "INSERT INTO `accounts_tokens` (`uid`, `token`, `ip`, `epoch_generated`) VALUES (?, ?, ?, ?)",
         (user["uid"], token, request_ip(request), int(epoch()))
      )

      return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
         "data": {
            "uid": user["uid"],
            "name": mask_string(user["name"]),
            "email":mask_email(user["email"]),
            "token": token,
            "country": get_country_for_ip(request_ip(request)) or "ZZ",
            "area_code": None # this could be filled in if GeoLite2-City is used
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling login event")
      return json_rsp_with_msg(define.RES_FAIL, "System error; please try again later.", {})

@app.route('/sdk/token_login', methods = ['GET'])
def sdk_token_login():
   try:
      cursor = get_db().cursor()

      token = cursor.execute("SELECT * FROM `accounts_tokens` WHERE `token` = ? AND `uid` = ?", (request.args.get("token"), request.args.get("uid"))).fetchone()
      if not token:
         return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Game account cache information error.", {})

      user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ?", (token["uid"],)).fetchone()
      if not user:
         print(f"Found valid account_token={token['token']} for uid={token['uid']}, but no such account exists")
         return json_rsp_with_msg(define.RES_LOGIN_ERROR, "System error; please try again later.", {}) # account for which token exists is not in db?

      return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
         "data": {
            "uid": user["uid"],
            "name": mask_string(user["name"]),
            "email": mask_email(user["email"]),
            "token": token["token"], # reuse existing token
            "country": get_country_for_ip(request_ip(request)) or "ZZ",
            "area_code": None # this could be filled in if GeoLite2-City is used
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling token login event")
      return json_rsp_with_msg(define.RES_FAIL, "System error; please try again later.", {})


# account
@app.route('/', methods = ['GET', 'POST'])
def account_register():
   cursor = get_db().cursor()

   if request.method == 'POST':
      user = cursor.execute("SELECT * FROM `accounts` WHERE `name` = ?", (request.form.get('username'), )).fetchone()
      if user:
         flash('Account with that username already exists.', 'error')
      elif not re.fullmatch(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b', request.form.get('email')):
         flash('Invalid email address provided.', 'error')
      elif request.form.get('password') != request.form.get('passwordv2'):
         flash('Provided passwords do not match.', 'error')
      elif len(request.form.get('password')) < get_config()["security"]["min_password_len"]:
         flash(f"Password must consists of at least {get_config()['security']['min_password_len']} characters.", 'error')
      else:
         cursor.execute(
            "INSERT INTO `accounts` (`name`, `email`, `password`, `epoch_created`) VALUES (?, ?, ?, ?)",
            (request.form.get('username'), request.form.get('email'), password_hash(request.form.get('password')), int(epoch()))
         )
         flash('Account created. Please close this page and log in in game.', 'success')

   return render_template("account/register.tmpl")


# sdk server
@app.route('/inner/account/verify', methods = ['GET'])
def inner_account_verify():
   try:
      cursor = get_db().cursor()

      token = cursor.execute("SELECT * FROM `accounts_tokens` WHERE `token` = ? AND `uid` = ?", (request.args.get("token"), request.args.get("uid"))).fetchone()
      if not token:
         return json_rsp(define.RES_SDK_VERIFY_FAIL, {})

      user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ?", (token["uid"], )).fetchone()
      if not user:
         print(f"Found valid token={token['token']} for uid={token['uid']}, but no such account exists")
         return json_rsp(define.RES_SDK_VERIFY_FAIL, {}) # account for which token exists is not in db?

      return json_rsp(define.RES_SDK_VERIFY_SUCC, {})
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling account verify event")
      return json_rsp(define.RES_SDK_VERIFY_FAIL, {})
