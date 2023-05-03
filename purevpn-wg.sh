#!/bin/bash

################################################################################
# Author: MA Junyi
# Date: 2023-05-03
#
# Description:
# This script sets up and runs an HTTP and SOCKS5 proxy service using PureVPN's WireGuard conf file.
#
# Usage:
# bash purevpn-wg.sh <location>-wg.conf
#
# Requirements:
# - wghttp must be installed on the system
#
# Notes:
# - This script is intended for use with PureVPN's Wireguard configuration file and may not
#   work with other VPN providers' configuration files.
#
################################################################################

# Check that a configuration file was specified as a parameter
if [ $# -eq 0 ]; then
  echo "Error: No configuration file specified."
  echo "Usage: $0 <config_file>"
  exit 1
fi

# Save the configuration file path from the first parameter
conf_file="$1"

# Check that the configuration file exists
if [ ! -f "$conf_file" ]; then
  echo "Error: Configuration file $conf_file not found."
  exit 1
fi

# Read the configuration file line by line
while read line; do
  # Check if the line includes an equal sign
  if [[ $line == *"="* ]]; then
    # Split the line into variable name and value
    var_name="${line%%=*}"
    var_value="${line#*=}"
    # Trim any whitespace around the variable value
    var_value="$(echo -e "${var_value}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    # If the variable is DNS and has multiple values separated by commas, save only the first value
    if [ "$var_name" == "DNS" ] && [[ "$var_value" == *,* ]]; then
      var_value="$(echo "$var_value" | cut -d',' -f1)"
    fi
    # Save the variable as an environment variable for further usage
    export "$var_name"="$var_value"
  fi
done < <(grep -v '^#' "$conf_file")

# Run wghttp using the configuration file
wghttp \
  --listen 127.0.0.1:9050 \
  --client-ip=$Address \
  --dns=$DNS \
  --private-key=$PrivateKey \
  --peer-key=$PublicKey \
  --peer-endpoint=$Endpoint \
  --keepalive-interval=20 \
  --exit-mode=remote
