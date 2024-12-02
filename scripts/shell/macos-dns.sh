#!/usr/bin/env bash
# https://github.com/dotkaio/config/
sudo scutil << EOF
get State:/Network/Service/gpd.pan/DNS
d.remove SearchDomains
d.remove ServerAddress
d.add ServerAddresses * 127.0.0.1 ::1
set State:/Network/Service/gpd.pan/DNS
exit
EOF
