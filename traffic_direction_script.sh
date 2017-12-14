#!/bin/bash

echo "Enter IP address"

read ip

cat /home/vcr/brologs/*/conn.log | bro-cut id.orig_h id.resp_h id.resp_p proto | awk -F '\t' -v var="$ip"  '$1 == var {print $2"\t"\
"---->""\t"$3"\t"$4"\t"$5}' | sort -u > $ip.txt

cat /home/vcr/brologs/*/conn.log | bro-cut id.orig_h id.resp_h id.resp_p proto | awk -F '\t' -v var="$ip"  '$2 == var {print $1"\t"\
"<----""\t"$3"\t"$4"\t"$5}' | sort -u >> $ip.txt
