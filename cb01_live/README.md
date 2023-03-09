## General information
- All services use network with subnet `172.10.3.0/24`
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