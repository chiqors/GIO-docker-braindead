# directory
CONFIG_FILE_PATH = "./data/config.json"
DB_PATH = "./data/sdk.db"
GEOIP2_DB_PATH = "./data/GeoLite2-Country.mmdb"
MI18N_PATH = './data/mi18n'


# account
ACCOUNT_TYPE_GUEST = 0
ACCOUNT_TYPE_NORMAL = 1


# scenes
SCENE_NORMAL = "S_NORMAL" # mobile + account; default to mobile
SCENE_ACCOUNT = "S_ACCOUNT" # mobile + account; default to account
SCENE_USER = "S_USER" # account only
SCENE_TEMPLE = "S_TEMPLE" # account only; no registration


# platform
PLATFORM_TYPE = {
   0: "EDITOR",
   1: "IOS",
   2: "ANDROID",
   3: "PC",
   4: "PS4",
   5: "SERVER"
}


# response
RES_SUCCESS = 0
RES_FAIL = -1
RES_CANCEL = -2
RES_NO_SUCH_METHOD = -10
RES_LOGIN_BASE = -100
RES_LOGIN_FAILED = -101
RES_LOGIN_CANCEL = -102
RES_LOGIN_ERROR = -103
RES_LOGOUT_FAILED = -104
RES_LOGOUT_CANCEL = -105
RES_LOGOUT_ERROR = 106
RES_EXIT_FAILED = -110
RES_EXIT_NO_DIALOG = -111
RES_EXIT_CANCEL = -112
RES_EXIT_ERROR = -113
RES_INIT_FAILED = -114
RES_INIT_ERROR = -115
RES_LOGIN_FORBIDDED = -117

RES_SDK_VERIFY_SUCC = 0
RES_SDK_VERIFY_FAIL = 1