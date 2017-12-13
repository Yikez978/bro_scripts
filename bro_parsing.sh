#!/bin/bash

now=$(date +"%Y%m%d")
path=/root/Desktop/current/pcaps/somedirectory/$now

mkdir /root/Desktop/Trend_Analysis/somedirectory/$now

#bro commands -r 
bro -r *.pcap frameworks/files/hash-all-files.bro; 

#bro commands to create CSV of time, sourceIP, SourcePort, DesitinationIP, DestinationPort, Protocol, Application
cat conn.log | awk -F '\t' '{print $1,","$3,","$4,","$5,","$6,","$7,","$8,","}' > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-conn.csv

#bro commands to create CSV of sourceIP, DestinationIP, Port, Protocol, Request
cat dns.log | awk -F '\t' '{print $3,"," $5,","  $6,"," $7,"," $9","}' | sort | uniq | sort -n > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-dns.csv

#bro commands to create CSV of sourceIP, Destination, requestType, Domain, request
cat http.log | awk -F '\t' '{print $3,","$5,","$7,","$8,","$9,","$10}' | sort | uniq | sort -n > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-http.csv

#bro commands to get files and export to csv filename, md5Hash, sha1Sum 
cat files.log | awk -F '\t' '$10 !~ "-" {print $10,","$6,","$8,","$20,","$21","}' | sort | uniq | > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-files.csv

#get emails from pcap
#ngrep -q -I file.pcap '[a-zA-Z0-9.]+\.?@[a-zA-Z0-9.]+\.[a-zA-Z0-9]+' | #grep -Eo '[a-zA-Z0-9.]+\.?@[a-zA-Z0-9.]+\.[a-zA-Z0-9]+' | sort | uniq > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-emails.csv

#get ssl information
cat ssl.log | awk -F '\t' '{print $3,","$5,","$6,",",$7,","$10","}' | sort | uniq -c | sort -n  > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-ssl.csv

#get rdp connections
cat rdp.log | awk -F '\t' '{print $3,","$5,","$6","}' | sort | uniq  > /root/Desktop/Trend_Analysis/somedirectory/$now/$now-somedirectory-Bro-rdp.csv


#echo "csvs created in Trend_Analysis. Copying logs to /root/Desktop/brologs/somedirectory/logs."
#read -p "Press any key to continue"
cd /root/Desktop/current/pcaps/somedirectory/$now
cp http.log dns.log files.log ssl.log conn.log $HOME/Desktop/brologs/somedirectory/logs


cp $path/*.pcap $path/"$now"_file.pcap


mkdir /root/Desktop/temporary_somedirectory/$now
cp *.log /root/Desktop/temporary_somedirectory/$now/

rm -rf $path/file_somedirectory_Raw.pcap

cp "$now"_file_somedirectory_Raw*.pcap /root/Desktop/temporary_somedirectory/$now/
cat $path/conn.log | bro-cut id.resp_h | awk -F '.' '$1 != "123" && $2 != "456" {print $1,$2,$3,$4}' | tr " " "." | sort -u | tr "\n" "," > $path/$now-somedirectory-IPs.txt
cat $path/http.log | bro-cut host | sort -u | tr "\n" "," > $path/$now-somedirectory-DOMAINNAMES.txt

cp *.txt /root/Desktop/temporary_somedirectory/$now/
cp /root/Desktop/Trend_Analysis/somedirectory/"$now"/*.csv /root/Desktop/temporary_somedirectory/$now
