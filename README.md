## Long start
Read the full detailed guide in file `GIO guide book for braindead` or read the quick start below if you are very skilled

## Quick start
1. Put server bins to the `server` folder
2. Put server data (json, lua, txt, xml, version.txt) to the `server/data` folder
3. Run docker using `bootstrap.bat` for Windows or `bootstrap.sh` for Linux. Please don't use commands like `docker-compose up -d` or `docker compose up -d`
4. Run fiddler, set up the fiddler script (`fiddler-script.txt`), use `bat`/`sh` only
5. Make sure you patched the game using UserAssembly.dll for Grasscutter (or RSA Patch since 3.3). Read the full guide if you dunno how to patch it
6. Wait for 15-30 minutes (Yes, it isn't a joke)
7. Run the game, play
8. If you want to make a public server - change `OUTER_IP` in `.env` file to your server ip, delete `.bootstrap.lock` file and rerun `bootstrap` `bat`/`sh` script (this action will erase all your database with the game progress). If you don't want to loose your progress - search `%OUTER_IP%` in `xml.tmpl` files and open related `xml` files without `.tmpl` extension and replace old IP to new IP in `.xml` files (not in `.xml.tmpl` - DON'T replace `%OUTER_IP%` in `.xml.tmpl`, edit only `.xml` files). Also search `%OUTER_IP%` in `.sql.tmpl` and see where you should change IP in real database (use phpmyadmin/adminer). DON'T replace `%OUTER_IP%` in `.sql.tmpl` - replace only in real database.

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

All RSA keys at the beginning are added to the database through a file `data.sql` (will be generated from `data.sql.tmpl`)

Also you can you special RSA patcher by `Hotaru` and add key for password too, for example:

### Dispatch
```
<RSAKeyValue><Modulus>x6DXVi3/8v/9W0kbDjAi/96yoZG30Fydk7hWxdR4dpqKP0M58aLScwmd49c1i+uUGmGNmSSP0yqH2gFr6QS3yhBTnvQ3cs1UYG/j1PAHUs263pQy5gZay7RW41G+Vm2cL1AzuXpoEQ9JXDpTbOlGwl8pin+enVSYjXAwLrOQKSVRC6vrlnjDX8ozf7mPCC8h7w2XfBfsmuL+K8UvE6KDKQshQYppjDSGi8AtsFScIUmTMmXYPjWdP+gN/iD2M/vjXQAvlunSvXkHgWJ2bo/45cfFbXlxrRfStdri3SC16yFaTR6FbPh+cwci1RSZE/G1yA4hjB4UdYrb/hsYfMpK7w==</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>
```
### Password
```
<RSAKeyValue><Modulus>yeF8n3X+VkwIhAdEK6Mp9ZGMW37N9tLWAlRnLkQ/7XccC7fim0LtK4FqEZLgnRvoPj0kWEhi6lWiY8v2gPdkKXhLqyTu/Cc2Ug+Let7U9t6Ez3gIdt3m5p499mbRFhx8ZuvZb6Q9I4++UXYWEfNisWADGOBl5qJD23FnMcTzjis=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>
```