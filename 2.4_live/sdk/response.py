from __main__ import app

from flask import Response, render_template
import json

import define

# error handlers
@app.errorhandler(404)
def page_not_found(e):
   print(f"ErrorHandler: {e=}, {e.description}")
   return render_template('404.tmpl'), 404


# custom json response
def json_rsp(code, data):
   return Response(json.dumps({"retcode": code} | data, separators=(',', ':')), mimetype='application/json')

def json_rsp_with_msg(code, msg, data):
   return Response(json.dumps({"retcode": code, "message": msg} | data, separators=(',', ':')), mimetype='application/json')