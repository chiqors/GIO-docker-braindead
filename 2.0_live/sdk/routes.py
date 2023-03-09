from __main__ import app

from flask import request, send_from_directory, abort, render_template, flash
import random
import string
import json
import re
from time import time as epoch

from response import json_rsp, json_rsp_with_msg
from database import get_db
from crypto import decrypt_rsa_password, decrypt_sdk_authkey
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


# sdk logging
@app.route('/log', methods = ['POST'])
@app.route('/log/sdk/upload', methods = ['POST'])
@app.route('/crash/dataUpload', methods = ['POST'])
@app.route('/sdk/dataUpload', methods = ['POST'])
@app.route('/common/h5log/log/batch', methods = ['POST'])
def sdk_log():
   return json_rsp(define.RES_SUCCESS, {})


# sdk config
@app.route('/data_abtest_api/config/experiment/list', methods = ['GET', 'POST'])
def abtest_config_experiment_list():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": []
   })

@app.route('/hk4e_cn/mdk/shield/api/loadConfig', methods = ['GET'])
@app.route('/hk4e_global/mdk/shield/api/loadConfig', methods = ['GET'])
def mdk_shield_api_loadConfig():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "client": define.PLATFORM_TYPE[int(request.args.get('client'))] if request.args.get('client').isnumeric() else request.args.get('client'),
         "disable_mmt": True, # disable captcha (geetest)
         "disable_regist": False, # ???
         "enable_email_captcha": False,
         "enable_ps_bind_account": False,
         "game_key": request.args.get('game_key'),
         "guest": get_config()["auth"]["enable_server_guest"],
         "server_guest": get_config()["auth"]["enable_server_guest"],
         "identity": "I_IDENTITY", # ???
         "name": "原神海外", # ???
         "scene": define.SCENE_USER, # CN only; controls which forms of authentication are enabled
         "thirdparty": [] # dont enable external login services
      }
   })

@app.route('/hk4e_cn/combo/granter/api/compareProtocolVersion', methods = ['POST'])
@app.route('/hk4e_global/combo/granter/api/compareProtocolVersion', methods = ['POST'])
def combo_granter_api_protocol():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "modified": False,
         "protocol": {}
      }
   })

@app.route('/hk4e_cn/combo/granter/api/getConfig', methods = ['GET'])
@app.route('/hk4e_global/combo/granter/api/getConfig', methods = ['GET'])
def combo_granter_api_config():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "disable_ysdk_guard": True, # ???
         "enable_announce_pic_popup": False, # ???
         "protocol": False, # ???
         "qr_enabled": False
      }
   })

@app.route('/combo/box/api/config/sdk/combo', methods = ['GET'])
def combo_box_api_config_sdk_combo():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "disable_email_bind_skip": False, # ???
         "email_bind_remind": False # ???
      }
   })

@app.route('/hk4e_cn/mdk/agreement/api/getAgreementInfos', methods = ['GET'])
@app.route('/hk4e_global/mdk/agreement/api/getAgreementInfos', methods = ['GET'])
def mdk_agreement_api_get():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "marketing_agreements": []
      }
   })

@app.route('/hk4e_cn/combo/red_dot/list', methods = ['POST'])
@app.route('/hk4e_global/combo/red_dot/list', methods = ['POST'])
def combo_red_dot_list():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "infos": [] # this can be dynamic based on player level and uid
      } 
   })

@app.route('/combo/box/api/config/sw/precache', methods = ['GET'])
def combo_box_api_config_sw_precache():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "vals": {
            "enable": False # whether to load service worker for analytics
         }
      } 
   })


# device-fp
@app.route('/device-fp/api/getExtList', methods = ['GET'])
def device_fp_get_ext_list():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "code": "200",
         "ext_list": [], # empty list disables fingerprinting client-side
         "pkg_list": None
      }
   })


# sdk account
@app.route('/account/risky/api/check', methods = ['POST'])
def account_risky_api_check():
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "id": "none",
         "action": define.RISKY_ACTION_NONE,
         "geetest": None
      }
   })

@app.route('/hk4e_cn/mdk/guest/guest/login', methods = ['POST'])
@app.route('/hk4e_cn/mdk/guest/guest/v2/login', methods = ['POST'])
@app.route('/hk4e_global/mdk/guest/guest/login', methods = ['POST'])
@app.route('/hk4e_global/mdk/guest/guest/v2/login', methods = ['POST'])
def mdk_guest_login():
   if not get_config()["auth"]["enable_server_guest"]:
      return json_rsp_with_msg(define.RES_LOGIN_CANCEL, "Guest accounts are disabled.", {}) # todo: this seems to bug client out if already logged-in as guest

   try:
      cursor = get_db().cursor()

      guest = cursor.execute("SELECT * FROM `accounts_guests` WHERE `device` = ?", (request.json["device"], )).fetchone()
      if not guest:
         cursor.execute("INSERT INTO `accounts` (`type`, `epoch_created`) VALUES (?, ?)", (define.ACCOUNT_TYPE_GUEST, int(epoch())))
         user = {"uid": cursor.lastrowid, "type": define.ACCOUNT_TYPE_GUEST}

         cursor.execute("INSERT INTO `accounts_guests` (`uid`, `device`) VALUES (?, ?)", (user["uid"], request.json["device"]))
      else:
         user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ? AND `type` = ?", (guest["uid"], define.ACCOUNT_TYPE_GUEST)).fetchone()
         if not user:
            print(f"Found valid account_guest={guest['uid']} for device={guest['device']}, but no such account exists")
            return json_rsp_with_msg(define.RES_LOGIN_ERROR, "System error; please try again later.", {}) # account for which guest binding exists is not in db?

      return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
         "data": {
            "account_type": user["type"],
            "guest_id": user["uid"]
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling guest login event")
      return json_rsp_with_msg(define.RES_FAIL, "System error; please try again later.", {})

@app.route('/hk4e_cn/mdk/shield/api/login', methods = ['POST'])
@app.route('/hk4e_global/mdk/shield/api/login', methods = ['POST'])
def mdk_shield_api_login():
   try:
      cursor = get_db().cursor()

      user = cursor.execute("SELECT * FROM `accounts` WHERE `name` = ? AND `type` = ?", (request.json["account"], define.ACCOUNT_TYPE_NORMAL)).fetchone()
      if not user:
         return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Incorrect username or password.", {})

      if get_config()["auth"]["enable_password_verify"]:
         if request.json["is_crypto"] == True:
            password = decrypt_rsa_password(request.json["password"])
         else:
            password = request.json["password"]

         if not password_verify(password, user["password"]):
            return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Incorrect username or password.", {})

      token = ''.join(random.choice(string.ascii_letters) for i in range(get_config()["security"]["token_length"]))
      cursor.execute(
         "INSERT INTO `accounts_tokens` (`uid`, `token`, `device`, `ip`, `epoch_generated`) VALUES (?, ?, ?, ?, ?)",
         (user["uid"], token, request.headers.get('x-rpc-device_id'), request_ip(request), int(epoch()))
      )

      return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
         "data": {
            "account": {
               "uid": user["uid"],
               "name": mask_string(user["name"]),
               "email":mask_email(user["email"]),
               "is_email_verify": False, # ???
               "token": token,
               "country": get_country_for_ip(request_ip(request)) or "ZZ",
               "area_code": None # this could be filled in if GeoLite2-City is used
            },
            "device_grant_required": False, # force email authorization of new device
            "realname_operation": None,
            "realperson_required": False,
            "safe_mobile_required": False # ???
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling shield login event")
      return json_rsp_with_msg(define.RES_FAIL, "System error; please try again later.", {})

@app.route('/hk4e_cn/mdk/shield/api/verify', methods = ['POST'])
@app.route('/hk4e_global/mdk/shield/api/verify', methods = ['POST'])
def mdk_shield_api_verify():
   try:
      cursor = get_db().cursor()

      token = cursor.execute("SELECT * FROM `accounts_tokens` WHERE `token` = ? AND `uid` = ?", (request.json["token"], request.json["uid"])).fetchone()
      if not token:
         return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Game account cache information error.", {})

      if token["device"] != request.headers.get('x-rpc-device_id'):
         return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Game account cache information error.", {}) # token was initially created on different device; forbid it

      user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ? AND `type` = ?", (token["uid"], define.ACCOUNT_TYPE_NORMAL)).fetchone()
      if not user:
         print(f"Found valid account_token={token['token']} for uid={token['uid']}, but no such account exists")
         return json_rsp_with_msg(define.RES_LOGIN_ERROR, "System error; please try again later.", {}) # account for which token exists is not in db?

      return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
         "data": {
            "account": {
               "uid": user["uid"],
               "name": mask_string(user["name"]),
               "email": mask_email(user["email"]),
               "is_email_verify": False, # ???
               "token": token["token"], # reuse existing token
               "country": get_country_for_ip(request_ip(request)) or "ZZ",
               "area_code": None # this could be filled in if GeoLite2-City is used
            }
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling shield verify event")
      return json_rsp_with_msg(define.RES_FAIL, "System error; please try again later.", {})

@app.route('/hk4e_cn/combo/granter/login/v2/login', methods = ['POST'])
@app.route('/hk4e_global/combo/granter/login/v2/login', methods = ['POST'])
def combo_granter_login_v2_login():
   try:
      cursor = get_db().cursor()
      data = json.loads(request.json["data"])

      if data["guest"]:
         guest = cursor.execute("SELECT * FROM `accounts_guests` WHERE `device` = ? AND `uid` = ?", (request.json["device"], data["uid"])).fetchone()
         if not guest:
            return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Game account cache information error.", {})

         user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ? AND `type` = ?", (data["uid"], define.ACCOUNT_TYPE_GUEST)).fetchone()
         if not user:
            print(f"Found valid account_guest={guest['uid']} for device={guest['device']}, but no such account exists")
            return json_rsp_with_msg(define.RES_LOGIN_ERROR, "System error; please try again later.", {}) # account for which guest binding exists is not in db?
      else:
         token = cursor.execute("SELECT * FROM `accounts_tokens` WHERE `token` = ? AND `uid` = ?", (data["token"], data["uid"])).fetchone()
         if not token:
            return json_rsp_with_msg(define.RES_LOGIN_FAILED, "Game account cache information error.", {})

         user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ? AND `type` = ?", (token["uid"], define.ACCOUNT_TYPE_NORMAL)).fetchone()
         if not user:
            print(f"Found valid account_token={token['token']} for uid={token['uid']}, but no such account exists")
            return json_rsp_with_msg(define.RES_LOGIN_ERROR, "System error; please try again later.", {}) # account for which token exists is not in db?

      combo_token = ''.join(random.choice('0123456789abcdef') for i in range(get_config()["security"]["token_length"]))
      cursor.execute(
         "INSERT OR REPLACE INTO `combo_tokens` (`uid`, `token`, `device`, `ip`, `epoch_generated`) VALUES (?, ?, ?, ?, ?)",
         (user["uid"], combo_token, request.json["device"], request_ip(request), int(epoch()))
      )

      return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
         "data": {
            "account_type": user["type"],
            "data": json.dumps({"guest": True if data["guest"] else False}, separators=(',', ':')),
            "fatigue_remind": None, # CN only; shows in-game reminder if playing too long
            "heartbeat": False, # CN only; forces game to send heartbeats so server can enforce maximum play time
            "open_id": data["uid"],
            "combo_token": combo_token
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling combo login event")
      return json_rsp_with_msg(define.RES_FAIL, "System error; please try again later.", {})

@app.route('/hk4e_cn/combo/granter/login/beforeVerify', methods = ['POST'])
@app.route('/hk4e_global/combo/granter/login/beforeVerify', methods = ['POST'])
def combo_granter_login_verify():
   # this should validate account_id and combo_token
   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "is_guardian_required": False,
         "is_heartbeat_required": False,
         "is_realname_required": False
      } 
   })


# shopwindow
@app.route('/hk4e_cn/mdk/shopwindow/shopwindow/listPriceTier', methods = ['POST'])
@app.route('/hk4e_global/mdk/shopwindow/shopwindow/listPriceTier', methods = ['POST'])
def price_tier_serve():
   # load all tiers config
   f = open(define.SHOPWINDOW_TIERS_PATH)
   tiers = json.load(f)
   f.close()

   currency = 'USD' # for simplicity sake we'll only support USD

   return json_rsp_with_msg(define.RES_SUCCESS, "OK", {
      "data": {
         "suggest_currency": currency,
         "tiers": tiers[currency]
      }
   })


# sdk server
@app.route('/inner/account/verify', methods = ['POST'])
def inner_account_verify():
   try:
      data = json.loads(request.data)
      cursor = get_db().cursor()

      token = cursor.execute("SELECT * FROM `combo_tokens` WHERE `token` = ? AND `uid` = ?", (data["combo_token"], data["open_id"])).fetchone()
      if not token:
         return json_rsp(define.RES_SDK_VERIFY_FAIL, {})

      user = cursor.execute("SELECT * FROM `accounts` WHERE `uid` = ?", (token["uid"], )).fetchone()
      if not user:
         print(f"Found valid combo_token={token['token']} for uid={token['uid']}, but no such account exists")
         return json_rsp(define.RES_SDK_VERIFY_FAIL, {}) # account for which token exists is not in db?

      return json_rsp(define.RES_SDK_VERIFY_SUCC, {
         "data": {
            "guest": True if user["type"] == define.ACCOUNT_TYPE_GUEST else False,
            "account_type": user["type"],
            "account_uid": token["uid"],
            "ip_info": {
               "country_code": get_country_for_ip(token["ip"]) or "ZZ"
            }
         }
      })
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while handling account verify event")
      return json_rsp(define.RES_SDK_VERIFY_FAIL, {})


# mi18n
@app.route('/admin/mi18n/plat_cn/m2020030410/m2020030410-version.json', methods = ['GET'])
@app.route('/admin/mi18n/plat_oversea/m2020030410/m2020030410-version.json', methods = ['GET'])
def mi18n_version():
   return json_rsp(define.RES_SUCCESS, {"version": 51})

@app.route('/admin/mi18n/plat_cn/m2020030410/m2020030410-<language>.json', methods = ['GET'])
@app.route('/admin/mi18n/plat_oversea/m2020030410/m2020030410-<language>.json', methods = ['GET'])
def mi18n_serve(language):
   return send_from_directory(define.MI18N_PATH, f"{language}.json")


# account 
@app.route('/')
@app.route('/sandbox/index.html', methods = ['GET'])
def account_index():
   return render_template("account/index.tmpl")

@app.route('/account/recover', methods = ['GET', 'POST'])
def account_recover():
   if request.method == 'POST':
      flash('Service currently unavailable.', 'error')

   return render_template("account/recover.tmpl")

@app.route('/account/register', methods = ['GET', 'POST'])
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
            "INSERT INTO `accounts` (`name`, `email`, `password`, `type`, `epoch_created`) VALUES (?, ?, ?, ?, ?)",
            (request.form.get('username'), request.form.get('email'), password_hash(request.form.get('password')), define.ACCOUNT_TYPE_NORMAL, int(epoch()))
         )
         flash('Account created. Please close this page and log in in game.', 'success')

   return render_template("account/register.tmpl")


# gacha
@app.route('/gacha/info/<int:id>', methods = ['GET'])
def gacha_info(id):
   
   schedule = {}
   textmap = {
      'title_map': {},
      'item_map': {}
   }
   language = request.args.get('lang') or 'en'

   # load details for this schedule
   try:
      f = open(f"{define.GACHA_SCHEDULE_PATH}/{id}.json")
      schedule = json.load(f)
      f.close()
   except Exception as err:
      abort(404, description=f"Unexpected {err=}, {type(err)=} while loading gacha schedule data for {id=}")

   # load textmap for desired language
   try:
      f = open(f"{define.GACHA_TEXTMAP_PATH}/{language}.json")
      textmap = json.load(f)
      f.close()
   except Exception as err:
      print(f"Unexpected {err=}, {type(err)=} while loading textmap for {language=}")

   return render_template("gacha/details.tmpl", schedule=schedule, textmap=textmap, id=id), 203

@app.route('/gacha/record/<int:type>', methods = ['GET'])
def gacha_log(type):
   return render_template("gacha/history.tmpl"), 203
