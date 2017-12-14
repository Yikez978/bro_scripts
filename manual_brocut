#!/bin/bash

echo What is the date of the log files?

read date

bro-cut host < http.log | sort -u > ${date}_bro_hosts.txt
bro-cut host < ssl.log | sort -u >> ${date}_bro_hosts.txt
bro-cut query < dns.log | sort -u >> ${date}_bro_hosts.txt
bro-cut id.orig_h < conn.log | sort -u > ${date}_bro_conn.txt
bro-cut id.resp_h < conn.log | sort -u >> ${date}_bro_conn.txt
bro-cut md5 < files.log | sort -u > ${date}_bro_md5.txt
bro-cut sha1 < files.log | sort -u > ${date}_bro_sha1.txt
bro-cut sha256 < files.log | sort -u > ${date}_bro_sha256.txt
bro-cut filename < files.log | sort -u > ${date}_bro_fileNames.txt
bro-cut uri < http.log | sort -u > ${date}_bro_requests.txt
