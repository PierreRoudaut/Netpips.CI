#!/bin/bash

NORMAL=$(tput sgr0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)

log_success() {
    printf "${GREEN}✔ %s${NORMAL}\n" "$@" >&2
}

log_failure() {
    printf "${RED}✖ %s${NORMAL}\n" "$@" >&2
}


assert_eq() {
    local expected="$2"
    local actual="$1"
    local msg

    if [ "$#" -ge 3 ]; then
	msg="$3"
    fi

    if [ "$expected" == "$actual" ]; then
	log_success "OK: $msg"
	return 0
    else
	log_failure "KO: $msg (Expected $expected, Got $actual)"
	return 1
    fi
}

dotnet --version &> /dev/null
assert_eq "$?" '0' 'dotnet is installed'

pgrep -a -u 'netpips' 2> /dev/null | grep 'dotnet' &> /dev/null
assert_eq "$?" '0' 'dotnet runs as netpips user'

service transmission-daemon status &> /dev/null
assert_eq "$?" '0' 'transmission-daemon service is running'

pgrep -a -u 'netpips' 2> /dev/null | grep 'transmission-daemon' &> /dev/null
assert_eq "$?" '0' 'transmission-daemon runs as netpips user'

filebot -version &> /dev/null
assert_eq "$?" '0' 'filebot is installed'

service plexmediaserver status &> /dev/null
assert_eq "$?" '0' "plex media server service is running"

service nginx status &> /dev/null
assert_eq "$?" '0' 'nginx service is running'

service netpips-server status &> /dev/null
assert_eq "$?" '0' 'netpips-server service is running'

service mssql-server status &> /dev/null
assert_eq "$?" '0' 'mssql-server service is running'

assert_eq $(source /home/netpips/.netpipsvarenv ; echo $NETPIPS_Netpips__HomePath) '/home/netpips' '.netpipsvarenv is properly set'

assert_eq $(source /home/netpips/.netpipsvarenv; curl $NETPIPS_Netpips__Domain/api/status 2> /dev/null | jq .ip --raw-output) '127.0.0.1' '/api/status OK'


# journalctl -fu netpips-server
