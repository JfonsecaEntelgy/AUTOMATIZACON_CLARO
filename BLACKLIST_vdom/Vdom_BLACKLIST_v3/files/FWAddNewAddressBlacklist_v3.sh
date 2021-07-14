#!/bin/expect

## Access CLI
set host [lindex $argv 0]
set loginUser [lindex $argv 1]
set loginPassword [lindex $argv 2]
set ipaddress [lindex $argv 3]
set vdom [lindex $argv 4]

eval spawn ssh -oStrictHostKeyChecking=no -oCheckHostIP=no $loginUser@$host
set prompt ":|#|\\\$"
interact -o -nobuffer -re $prompt return
send "$loginPassword\r"
set timeout 2
expect "#"
send "config vdom"
expect "#"
send "edit $vdom"
expect "#"
send "config firewall address\n"
expect "(address) #"
send "edit $ipaddress/32\n"
expect "($ipaddress/32) #"
send "set subnet $ipaddress 255.255.255.255\n"
expect "($ipaddress/32) #"
send "next\n"
expect "(address) #"
send "end\n"
expect "#"
send "config vdom"
expect "#"
send "edit $vdom"
expect "#"
send "config firewall addrgrp\n"
expect "(addrgrp) #"
send "edit BlackList\n"
expect "(BlackList) #"
send "append member $ipaddress/32\n"
expect "(BlackList) #"
send "next\n"
expect "(addrgrp) #"
send "end\n"
expect "#"; exit 0
expect eof
