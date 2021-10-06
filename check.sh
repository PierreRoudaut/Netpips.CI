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

python_verision=$(python --version)
assert_eq "$python_verision" 'Python 3.9.5' 'Python 3.9.5 is installed'

nodejs --version &> /dev/null
assert_eq "$?" '0' 'nodejs is installed'

mediainfo --version &> /dev/null
assert_eq "$?" '0' 'mediainfo is installed'

dotnet --version &> /dev/null
assert_eq "$?" '0' 'dotnet is installed'

pgrep -a -u 'netpips' 2> /dev/null | grep 'dotnet' &> /dev/null
assert_eq "$?" '0' 'dotnet runs as netpips user'

service netpips-server status &> /dev/null
assert_eq "$?" '0' 'netpips-server service is running'

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
ipv4=$(hostname -I  | cut -d' ' -f1)
assert_eq $(curl -sL -w "%{http_code}" http://$ipv4 -o /dev/null) '200' "nginx serving 200 OK on http://$ipv4"

service mssql-server status &> /dev/null
assert_eq "$?" '0' 'mssql-server service is running'

test_settings_path=/home/netpips/netpips.test.settings.json
[ -f "$test_settings_path" ]
assert_eq "$?" '0' "$test_settings_path exists"

prod_settings_path=/home/netpips/netpips.Production.settings.json
[ -f "$prod_settings_path" ]
assert_eq "$?" '0' "$prod_settings_path exists"


DOMAIN=netpips
assert_eq $(curl -sL -w "%{http_code}" https://$DOMAIN/api/status -o /dev/null) '200' "https://$DOMAIN/api/status 200 OK"

assert_eq $(curl -sL -w "%{http_code}" https://$DOMAIN/index.html -o /dev/null) '200' "https://$DOMAIN/index.html 200 OK"
