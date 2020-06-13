#!/bin/bash

systemctl start mysql
systemctl start redis-server
systemctl start apache2
systemctl start virtualcontrol

tail -f /dev/null
