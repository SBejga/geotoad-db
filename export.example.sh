#!/usr/bin/env bash
# little helper to set environment variables
# create your own
#
# $ source export.sh
#

export GEOTOAD_MONGOHOST=
export GEOTOAD_MONGOPORT=
# if you use authentication
#export GEOTOAD_MONGOUSER=
#export GEOTOAD_MONGOPASS=
#export GEOTOAD_MONGOAUTH=
export GEOTOAD_MONGODB=

echo "$GEOTOAD_MONGOUSER:$GEOTOAD_MONGOPASS - $GEOTOAD_MONGOHOST:$GEOTOAD_MONGOPORT/$GEOTOAD_MONGODB"
echo " "
echo "you could test:"
echo "$GEOTOAD_BIN -U -x gpx -o test.gpx -q wid GC4ZG3N"
