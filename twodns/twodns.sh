#!/bin/bash
# following the official API this was created
# https://www.twodns.de/en/api

# you'll need curl for this
if [ ! -e /usr/bin/curl ]; then
    echo "curl not found"
    exit 2;
fi 

print_help() {
cat <<EOF
Usage: {$##*/} [-ug]
Update or get information from TwoDNS regarding DSL Information.

   -u	update IP
   -g	get info
   -v	enable verbose mode for curl
   -s	enable silent mode for curl
   -h	print help
EOF
}

die() {
    echo "$1 not set"
    exit 1;
}

# source variables
source ~/.twodns.rc

# check variables
[ -z $USER ] &&  die "login name"
[ -z $API_TOKEN ] && die "API token"
[ -z $FQDN ] && die "FQDN"

#
MODE='update'
VERBOSITY='-s'

# reset/clear getops
OPTIND=1

while getopts "hugvs" opt; do
    case "$opt" in
	h)
	    print_help
	    exit 0;
	    ;;
	u)
	    MODE="update"
	    ;;
	g)
	    MODE="get"
	    ;;
	v)
	    VERBOSITY="-v"
	    ;;
	s)
	    VERBOSITY="-s"
	    ;;
	'?')
	    print_help >&2
	    exit 0;
	    ;;
    esac
done
shift "$((OPTIND-1))" # Shift off the options and optional --.

# 
case "$MODE" in 

    "update")
	curl $VERBOSITY -X PUT -u "$USER:$API_TOKEN" \
	    -d '{"ip_address": "auto", "ttl": "300"}' \
	    https://api.twodns.de/hosts/$FQDN
	;;
    "get")
	curl $VERBOSITY -X GET -u "$USER:$API_TOKEN" \
	    https://api.twodns.de/hosts/$FQDN
	;;
esac
