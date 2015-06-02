#!/bin/bash
#
# this is beerware, have fun
#
if [ -z $1 ]; then
    printf "which month to download?\n"
    printf "use: $0 <YEAR-MONTH>\n example: $0 15-03\n\n"
    exit -1;
fi
MONTH=$1
DOD='http://www.dwellingofduels.net/index.php?option=com_content&view=article&id=50&Itemid=53'

USERAGENT='Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0'

DL_BASE=$(lynx --dump $DOD|grep $MONTH | cut -c 7-)
LDIR=$( echo $DL_BASE| sed -e 's/.*dir=//'|sed -e 's/\&.*//' )

if [ ! -d $LDIR ]; then
    mkdir "$LDIR"
fi
cd "$LDIR/"

FILES=$(lynx --dump $DL_BASE|cut -c 7- |grep '^http://www'| grep mp3)
IFS='
'
for i in $FILES; do
    wget -U "$USERAGENT" "$i"
done
IFS=''

cd ../
