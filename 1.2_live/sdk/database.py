from __main__ import app

from flask import g
import sqlite3

import define

def dict_factory(cursor, row):
   d = {}
   for idx, col in enumerate(cursor.description):
      d[col[0]] = row[idx]
   return d

def get_db():
   db = getattr(g, '_database', None)
   if db is None:
      db = g._database = sqlite3.connect(define.DB_PATH)
      db.row_factory = dict_factory
   return db

def init_db():
   conn = sqlite3.connect(define.DB_PATH)
   cursor = conn.cursor()

   cursor.execute("""CREATE TABLE `accounts` (
                     `uid` INTEGER NOT NULL,
                     `name`  TEXT UNIQUE,
                     `email` TEXT UNIQUE,
                     `password`  TEXT,
                     `type`  INTEGER NOT NULL,
                     `epoch_created` INTEGER NOT NULL,
                     PRIMARY KEY(`uid` AUTOINCREMENT)
                  )
   """)
   cursor.execute("""CREATE TABLE `accounts_tokens` (
                     `uid` INTEGER NOT NULL,
                     `token` TEXT NOT NULL,
                     `device`  TEXT NOT NULL,
                     `ip`  TEXT NOT NULL,
                     `epoch_generated` INTEGER NOT NULL,
                     PRIMARY KEY(`uid`,`token`)
                  )
   """)
   cursor.execute("""CREATE TABLE `accounts_guests` (
                     `uid` INTEGER NOT NULL,
                     `device` TEXT NOT NULL,
                     PRIMARY KEY(`uid`,`device`)
                  )
   """)
   cursor.execute("""CREATE TABLE `accounts_thirdparty` (
                     `uid` INTEGER NOT NULL,
                     `type`  INTEGER NOT NULL,
                     `external_name` TEXT NOT NULL,
                     `external_id` INTEGER NOT NULL,
                     PRIMARY KEY(`uid`,`type`)
                  )
   """)
   cursor.execute("""CREATE TABLE `thirdparty_tokens` (
                     `uid` INTEGER NOT NULL,
                     `type`  INTEGER NOT NULL,
                     `token` TEXT NOT NULL
                  )
   """)
   cursor.execute("""CREATE TABLE `combo_tokens` (
                     `uid` INTEGER NOT NULL,
                     `token` TEXT NOT NULL,
                     `device`  TEXT NOT NULL,
                     `ip`  TEXT NOT NULL,
                     `epoch_generated` INTEGER NOT NULL,
                     PRIMARY KEY(`uid`)
                  )
   """)

   conn.commit()
   conn.close()

@app.teardown_appcontext
def close_connection(exception):
   db = getattr(g, '_database', None)
   if db is not None:
      db.commit()
      db.close()