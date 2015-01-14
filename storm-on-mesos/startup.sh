#!/bin/bash

#Actual scripts located at /etc/storm
service storm-nimbus-start
sleep 5.0
echo "Executing 'ps -ef | grep storm'..."; sleep 0.3
ps -ef | grep storm
echo "Printing nimbus.out..."; sleep 0.3
cat /mnt/storm-logs/nimbus.out
sleep 0.3
service storm-ui-start
sleep 5.0
echo "Printing ui.out..."
tail /mnt/storm-logs/ui.log