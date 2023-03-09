from flask import g
import json

import define

def load_config():
   with open(define.CONFIG_FILE_PATH) as file:
     return json.load(file)

def get_config(): # config is reloadable per-request except for "app" section
   config = getattr(g, '_config', None)
   if config is None:
      with open(define.CONFIG_FILE_PATH) as file:
        config = g._config = load_config()
   return config