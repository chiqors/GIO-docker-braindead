1. Install Windows Subset Linux 2
https://learn.microsoft.com/en-us/windows/wsl/install-manual

2. Install Docker Desktop
https://docs.docker.com/desktop/install/windows-install/

3. Install FiddlerSetup (see requirements folder)

4. Allow https decrypt in Fiddler settings, install certificate

5. Go to "fiddler script" tab and replace all to:

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
               
                // Only for Yuuki servers
                //oS.host = "de.game.yuuki.me";
                //oS.host = "sg.game.yuuki.me";
            
                // Only for GIO/localhost/etc
                //oS.host = "192.168.200.130";
                oS.host = "127.0.0.1";
                oS.oRequest.headers.UriScheme = "http";
                //oS.port = 21000;
                oS.port = 8080;
                //oS.port = 443;
            
                // Only for CBT-1
                //oS.oRequest.headers.UriScheme = "http";
                //oS.port = 8099;
                
                break;
            }
        }
        
    }
};


6. Copy your server bins to:
bin/3.2_beta/hk4e_output

7. Copy your server data (json, lua, txt, xml folders and version.txt file) to:
data/welink_3.2_qa

Please DON'T replace:
- data/welink_3.2_qa/version.txt
- data/welink_3.2_qa/txt/DailyDungeonData.txt
- data/welink_3.2_qa/txt/GachaPoolData.txt
- data/welink_3.2_qa/txt/QuestData_Exported.txt

8. Patch your game client - just use patched UserAssembly.dll for Grasscutter

9. Start: run in terminal "docker compose up -d" or run "start.bat" (Windows) / "start.sh" (Linux)

10. Run game and play

11. Stop: run in terminal "docker compose down" or run "stop.bat" (Windows) / "stop.sh" (Linux)
