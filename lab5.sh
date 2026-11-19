 #!/bin/bash


count=0

cat /etc/hosts | while read -r b; do

if [ -z "$b" ]; then

continue

fi

count=$((count+1))

if [ "$count" -gt "8" ]; then

read -r ip nume <<< "$b"

nslookup $nume | grep "Adress: "


linie=$(nslookup "$nume" | grep "^Address: " | head -n 1)

read -r eticheta ip_real <<< "$linie"


if [ "$ip" != "ip_real" ];then

echo "Bogus IP for $nume in /etc/hosts!"

fi


fi



done 