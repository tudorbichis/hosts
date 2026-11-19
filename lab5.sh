#!/bin/bash
verifica_ip() {
    local nume_host="$1"
    local ip="$2"
    local server_dns="$3"

    linie=$(nslookup "$nume_host" "$server_dns" | tail -n +6 | head -n 1)
    read -r _ ipreal <<< "$linie"

    if [ "$ip" != "$ipreal" ]; then
        echo "Bogus IP for $nume_host in /etc/hosts!"
    else
        echo "Valid IP for $nume_host ($ip)"
    fi
}

count=0

cat /etc/hosts | while read -r b; do
    if [ -z "$b" ]; then
        continue
    fi

    count=$((count+1))

    if [ "$count" -gt "8" ]; then
        read -r ip nume <<< "$b"
        verifica_ip "$nume" "$ip" "8.8.8.8"
    fi
done
echo "studentA: VM tudorbichis2"
