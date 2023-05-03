# purevpn-wg

This bash script sets up and runs an HTTP and SOCKS5 proxy service using PureVPN's WireGuard conf file.

## Usage

To use the script, simply run it with the PureVPN configuration file as a parameter:

```bash
bash purevpn-wg.sh <location>-wg.conf
```

## Requirements

This script requires the following dependencies:

[wghttp](https://github.com/zhsj/wghttp)
PureVPN's Wireguard conf file

Please refer to [this guide](https://medium.com/@mjyai/aae05f9f352f) for instructions on the installation of wghttp and acquisition of the Wireguard configuration file for PureVPN.

## Notes

If the PureVPN configuration file includes multiple DNS values separated by commas, only the first value will be used.
This script has been tested on Ubuntu 22.04 and Centos 7.5.
This script is provided as-is, without any warranties or guarantees of any kind. Use at your own risk.
