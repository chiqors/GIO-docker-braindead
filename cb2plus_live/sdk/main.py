from flask import Flask
from werkzeug.middleware.proxy_fix import ProxyFix
app = Flask(__name__)

import sys

from config import load_config
import database
import routes

if __name__ == '__main__':
   config = load_config()

   app.secret_key = config["app"]["secret_key"]
   app.debug = config["app"]["debug"]
   app.wsgi_app = ProxyFix(app.wsgi_app, x_proto=1, x_host=1)

   if sys.argv[1] == "serve":
      print(">> Starting Flask server instance...")
      app.run(config["app"]["listen"], config["app"]["port"])
   elif sys.argv[1] == "initdb":
      print(">> Initializing database structure...")
      database.init_db()
      print(">> Done!")
   else:
      raise Exception("Unsupported operation; must be one of: serve, initdb")