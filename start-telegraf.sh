# Author : Adrian Banu
# Date : 08-Jun-2020
# Description : Start script for perftest telegraf
# Updates:
#	08-Jun-2020	- Adrian Banu	- Initial Setup
#

if ! pgrep -x "telegraf" > /dev/null
then
    export _JAVA_OPTIONS="-Djava.net.preferIPv4Stack=true"
    export http_proxy=
    export HTTP_PROXY=
    export EC2_IPADDRESS=$(hostname -I | awk '{print $1}')
    export EC2_HOSTNAME=$(hostname)

    echo "******************************** NEW ENV VARIABLES DEFINED: ********************************"
    echo " "
    echo " "
    echo EC2_IPADDRESS=$EC2_IPADDRESS
    echo EC2_HOSTNAME=$EC2_HOSTNAME

    telegraf_path=$(pwd)

    #Start Telegraf
    export PATH=$PATH:$telegraf_path/usr/bin
    export TELEGRAF_CONFIG_PATH=$telegraf_path/etc/telegraf/telegraf.conf

    nohup $telegraf_path/usr/bin/telegraf -config $TELEGRAF_CONFIG_PATH &

    echo " "
    echo " "
    echo "************************************ STARTING TELEGRAF  ************************************"
    echo " "
    echo " "
    echo "----------------------------------------------------------------------------------------------"

    sleep 3

    echo " "
    echo " "
    echo "For console output, run 'tail -f $telegraf_path/nohup.out'"
    echo " "
    echo " "
    echo "Telegraf process list"
    echo "----------------------"
    echo " "
    ps -ef | grep telegraf.conf | grep bin
    echo " "
    echo " "

else
    echo "Telegraf is running. Do nothing!"
fi
