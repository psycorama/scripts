#!/bin/bash
# following the official API this was created
# https://www.twodns.de/en/api
#
# 2014 (c) by Andreas Geisenhainer <psycorama@opensecure.de>
# Licensed under GNU GPL v3

# you'll need curl for this
if [ ! -e /usr/bin/curl ]; then
    echo "curl not found"
    exit 2;
fi

print_help() {
cat <<EOF
Usage: {$##*/} [-ugG]
Update or get information from TwoDNS regarding DSL Information.

   -u	update IP (default)
   -g	get info
   -G	get info on all hosts
   -v	enable verbose mode for curl
   -s	enable silent mode for curl (default)
   -l   enable update of local file
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
LOCAL_FILE='/tmp/online'
UPDATE_LOCAL=0
OLD_IP=""
# reset/clear getops
OPTIND=1

while getopts "hugGvsl" opt; do
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
	G)
	    MODE="getall"
	    ;;
	v)
	    VERBOSITY="-v"
	    ;;
	s)
	    VERBOSITY="-s"
	    ;;
	l)
	    UPDATE_LOCAL=1
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
	if [ -r $LOCAL_FILE ]; then
	    OLD_IP=$(cat $LOCAL_FILE)
	fi
	RET=$( curl $VERBOSITY -X PUT -u "$USER:$API_TOKEN" \
		-d '{"ip_address": "auto", "ttl": "300"}' \
		https://api.twodns.de/hosts/all )

	if [ $UPDATE_LOCAL -eq 1 ]; then
	    for field in $(echo $RET|tr "," "\n"| sed -e 's/"//g' ); do
		if [ "$(echo $field| cut -d ":" -f 1)" == "ip_address" ]; then
		    #printf "%s : %s\n" $( echo $i| cut -d ":" -f 1 )
		    NEW_IP="$(echo $field| cut -d ':' -f 2)"
		    if [ $OLD_IP != $NEW_IP ]; then
			echo $NEW_IP > /tmp/online
			break
		    fi
		fi
	    done
	fi
	;;
    "get")
	curl $VERBOSITY -X GET -u "$USER:$API_TOKEN" \
	    https://api.twodns.de/hosts/$FQDN
	echo ""
	;;
    "getall")
	curl $VERBOSITY -X GET -u "$USER:$API_TOKEN" \
	    https://api.twodns.de/hosts
	echo ""
	;;
esac
