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

## Administration
- Adminer instance is available on `172.10.3.102`
- SDK server has password verification _disabled_ by default; use `enable_password_verify` option in `config.json` to control it
- SDK server has guest accounts _enabled_ by default; use `enable_server_guest` option in `config.json` to control it
- Services have `DEBUG` logs masked (disabled) by default; use `Root.LogConf.LogLevelMask` option to control it

## RSA keys
### Dispatch
```
<RSAKeyValue><Modulus>x6DXVi3/8v/9W0kbDjAi/96yoZG30Fydk7hWxdR4dpqKP0M58aLScwmd49c1i+uUGmGNmSSP0yqH2gFr6QS3yhBTnvQ3cs1UYG/j1PAHUs263pQy5gZay7RW41G+Vm2cL1AzuXpoEQ9JXDpTbOlGwl8pin+enVSYjXAwLrOQKSVRC6vrlnjDX8ozf7mPCC8h7w2XfBfsmuL+K8UvE6KDKQshQYppjDSGi8AtsFScIUmTMmXYPjWdP+gN/iD2M/vjXQAvlunSvXkHgWJ2bo/45cfFbXlxrRfStdri3SC16yFaTR6FbPh+cwci1RSZE/G1yA4hjB4UdYrb/hsYfMpK7w==</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>
```
### Password
```
<RSAKeyValue><Modulus>yeF8n3X+VkwIhAdEK6Mp9ZGMW37N9tLWAlRnLkQ/7XccC7fim0LtK4FqEZLgnRvoPj0kWEhi6lWiY8v2gPdkKXhLqyTu/Cc2Ug+Let7U9t6Ez3gIdt3m5p499mbRFhx8ZuvZb6Q9I4++UXYWEfNisWADGOBl5qJD23FnMcTzjis=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>
```