#!/bin/bash
#===============================================================================
#
#          FILE:  mongo_start_stop.sh 
#
#         USAGE:  ./mongo_start_stop.sh [start|stop|restart] 
#
#   DESCRIPTION:  Start, stop or restart unix mongodb-server 
#
#       OPTIONS:  ---  
#
#	   TODO:  logging
#                 
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  Patrick Kowalik, kowalik.patrick@online.de
#    REPOSITORY:  https://github.com/patrick0585/Mongo_Start_Stop
#       COMPANY:  ---
#       VERSION:  1.0.0
#       CREATED:  10/05/2017 12:00:00 PM MDT
#      REVISION:  ---
#===============================================================================

VERSION=1.0.0
SCRIPTNAME=$(basename $0)
MONGOHOME=""
MONGOBIN="$MONGOHOME/bin"
MONGOD="$MONGOBIN/mongod"
MONGODBPATH=""
MONGODBCONFIG=""


if [ $# != 1 ]
then
	echo "Usage: $SCRIPTNAME [start|stop|restart]"
	exit;
fi

function isRunning {
    PID=$(ps -ef | grep "[m]ongodb" | awk {'print $2'})
    echo $PID    
}

function stopServer {
    rc=$(isRunning)
    echo "... stopping mongodb-server with pid: $rc"    
    if [ ! -z "$rc" ]; then
	sudo kill $rc
    fi
}

function startServer {
    echo "... starting mongodb-server"
    rc=$(isRunning)
    if [ ! -z "$rc" ];then
        stopServer $rc
    fi
    sudo $MONGOD --dbpath $MONGODBPATH --config $MONGODBCONFIG
}

function restartServer {
    stopServer
    startServer    
}

case "$1" in

	start) echo "start"
	       startServer
	       ;;

	stop) echo "stop"
	       stopServer
	       ;;

	restart) echo "restart"
		 restartServer
		 ;;
	
	*) echo "unknown command"
	   exit;
	   ;;
esac
