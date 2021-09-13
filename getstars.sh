#!/bin/bash
 
user="$1"
pages=$(curl -I https://api.github.com/users/$user/starred | sed -nr 's/^link:.*page=([0-9]+).*/\1/p')

for page in $(seq 1 $pages); do
    curl "https://api.github.com/users/$user/starred?page=$page&per_page=30" | jq -r '.[].html_url' |
    while read rp; do
      git clone $rp
    done
done
