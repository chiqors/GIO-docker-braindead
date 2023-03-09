## Start
1. Put server bins to the `server` folder
2. Put server data (json, lua, txt, xml, version.txt) to the `server/data` folder
3. Run docker using `bootstrap.bat` for Windows or `bootstrap.sh` for Linux. Please don't use commands like `docker-compose up -d` or `docker compose up -d`
4. Run fiddler, set up the fiddler script (below), use `bat`/`sh` only
5. Make sure you patched the game using UserAssembly.dll for Grasscutter (or RSA Patch since 3.3)
6. Wait for 15-30 minutes (Yes, it isn't a joke)
7. Run the game, play
8. If you want to make a public server - change `OUTER_IP` in `.env` file to your server ip, delete `.bootstrap.lock` file and rerun `bat`/`sh` script

## Fiddler script
```
import System;
import System.Windows.Forms;
import Fiddler;
import System.Text.RegularExpressions;

class Handlers
{
    static function OnBeforeRequest(oS: Session) {
      
        // Enable/Disable entire script
        //return;   
        
        var blocks =
            [
                ":8888/log",
                "/sdk/dataUpload",
                "/sdk/dataUpload",
                "/common/h5log/log/batch",
                "/crash/dataUpload"
            ];
        
        for (var i = 0; i < blocks.length; i++) {
            if (oS.uriContains(blocks[i])) {
                oS.oRequest.FailSession(404, "Blocked", "Oh no!!!");
            }
        }
     
        
        var redirects =
        [
            ".yuanshen.com",
            ".hoyoverse.com",
            ".mihoyo.com",
            ".yuanshen.com:12401"
        ];
        
        
        for (var i = 0; i < redirects.length; i++) {
            if (oS.host.EndsWith(redirects[i])) {
                oS.host = "127.0.0.1";
                oS.oRequest.headers.UriScheme = "http";
                oS.port = 21000;
                break;
            }
        }
        
    }
};
```

## General information
- All services use network with subnet `172.10.3.0/24`
- Following services are masked (disabled) by using profile `donotstart`:
  - oaserver
  - pathfindingserver
  - tothemoonserver
- Following ports need to be open if you plan to expose your server to public:
  - `21081/udp` for `gateserver`
  - `21000/tcp` for SDK server
- R/W MySQL user is set to `hk4e_work` and R/O to `hk4e_readonly`; both accounts have their password set to `miHoYo2012`
- Redis password is set to `miHoYo2012`
- `muipserver`'s signing key is set to `9H2UrJ5J4yZJf95FqMkqi628snEmzvyV9oAp`


## Passwords
- All passwords in .env file


## Administration
- Adminer instance is available on `127.0.0.1:8085`, use root as login and see password in .env file
- PHPMyAdmin instance is available on `127.0.0.1:8087`, use root as login and see password in .env file
- SDK server has password verification _disabled_ by default; use `enable_password_verify` option in `config.json` to control it
- SDK server has guest accounts _enabled_ by default; use `enable_server_guest` option in `config.json` to control it
- Services have `DEBUG` logs masked (disabled) by default; use `Root.LogConf.LogLevelMask` option to control it


## RSA keys
Use patched `UserAssembly.dll`/`RSAPatch.dll`/`Metadata` for Grusscutter because these patches have same RSA keys as in the current database, see table:
`hk4e_db.hk4e_db_deploy_config.t_rsakey_config`
