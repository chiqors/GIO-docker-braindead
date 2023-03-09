## General information
- All services use network with subnet `172.10.3.0/24`
- Following services are masked (disabled) by using profile `donotstart`:
    - oaserver
    - pathfindingserver
- Following ports need to be open if you plan to expose your server to public:
    - `21081/udp` for `gateserver`
    - `21000/tcp` for SDK server
- R/W MySQL user is set to `hk4e_work` and R/O to `hk4e_readonly`; both accounts have their password set to `miHoYo2012`
- Redis password is set to `miHoYo2012`
- `muipserver`'s signing key is set to `9H2UrJ5J4yZJf95FqMkqi628snEmzvyV9oAp`

## Administration
- Adminer instance is available on `172.10.3.102`
- SDK server has password verification _disabled_ by default; use `enable_password_verify` option in `config.json` to control it
- SDK server has guest accounts _enabled_ by default; use `enable_server_guest` option in `config.json` to control it
- Services have `DEBUG` logs masked (disabled) by default; use `Root.LogConf.LogLevel` option to control it

## RSA keys
### Password
```
<RSAKeyValue><Modulus>yeF8n3X+VkwIhAdEK6Mp9ZGMW37N9tLWAlRnLkQ/7XccC7fim0LtK4FqEZLgnRvoPj0kWEhi6lWiY8v2gPdkKXhLqyTu/Cc2Ug+Let7U9t6Ez3gIdt3m5p499mbRFhx8ZuvZb6Q9I4++UXYWEfNisWADGOBl5qJD23FnMcTzjis=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>
```