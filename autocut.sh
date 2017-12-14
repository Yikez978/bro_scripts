#!/bin/bash
###########################################################################################
#				 MANUAL SPLIT/RENAME					  #
#			   UNCOMMENT ALL BUT LINES 12 and 13				  #
###########################################################################################
#now=$(date +"%Y%m%d")
#homeloc="$HOME/Desktop/brologs/$now"
#homeloc2="$HOME/Desktop/brologs/product/texts/$now/"
#read -p "Cut logs, Continue? (yes/no)" CONT
#if [ "$CONT" == "y|Y|Yes|YES|yes" ]; then
	#mkdir $homeloc
	#mkdir $homeloc2
	#bro-cut host < http.log | sort -u > $homeloc2/"${now}_bro_hosts.txt"
	#bro-cut host < ssl.log | sort -u >> $homeloc2/"${now}_bro_hosts.txt"
	#bro-cut query < dns.log | sort -u >> $homeloc2/"${now}_bro_hosts.txt"
	#bro-cut id.orig_h < conn.log | sort -u > $homeloc2/"${now}_bro_conn.txt"
	#bro-cut id.resp_h < conn.log | sort -u >> $homeloc2/"${now}_bro_conn.txt"
	#bro-cut md5 < files.log | sort -u > $homeloc/"${now}_bro_md5"
	#bro-cut sha1 < files.log | sort -u > $homeloc/"${now}_bro_sha1"
	#bro-cut sha256 < files.log | sort -u > $homeloc2/"${now}_bro_sha256.txt"
	#bro-cut filename < files.log | sort -u > $homeloc2/"${now}_bro_fileNames.txt"
	#bro-cut uri < http.log | sort -u > $homeloc/"${now}_bro_requests"

	#cp $HOME/Desktop/scripts/split.sh "$homeloc"/
	#chmod 755 $homeloc/split.sh
#else
	#echo "exiting";
#fi
#printf "\n"
###########################################################################################
#				 AUTOMATED PORTION					  #
###########################################################################################
now=$(date +"%Y%m%d")
homeloc="$HOME/Desktop/brologs/$now"
mkdir $homeloc
bro-cut host < http.log | sort -u > $homeloc/"${now}_bro_hosts"
bro-cut host < ssl.log | sort -u >> $homeloc/"${now}_bro_hosts"
bro-cut query < dns.log | sort -u >> $homeloc/"${now}_bro_hosts"
bro-cut id.orig_h < conn.log | sort -u > $homeloc/"${now}_bro_conn"
bro-cut id.resp_h < conn.log | sort -u >> $homeloc/"${now}_bro_conn"
bro-cut md5 < files.log | sort -u > $homeloc/"${now}_bro_md5"
bro-cut sha1 < files.log | sort -u > $homeloc/"${now}_bro_sha1"
bro-cut sha256 < files.log | sort -u > $homeloc/"${now}_bro_sha256"
bro-cut filename < files.log | sort -u > $homeloc/"${now}_bro_fileNames"
bro-cut uri < http.log | sort -u > $homeloc/"${now}_bro_requests"
cp $HOME/Desktop/scripts/split.sh "$homeloc"/
