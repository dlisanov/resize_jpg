#!/bin/bash
puth="/var/www/kuzgadm4/data/www/gorodkuzneck.ru/upload"
expansions=("*.jpg" "*.JPG")
if [ -f files.txt ]; then
    rm files.txt
fi
for expansion in ${expansions[@]}; do
    find $puth -name $expansion -size +1M > files.txt
    while read file
    do
        width=$(identify -format "%w" "$file")
        resolution_old=$(identify -format "%wx%h" "$file")
        if [ $width -gt 1024 ];
        then
            convert "$file" -resize 1024 "$file"
            resolution_new=$(identify -format "%wx%h" "$file")
            echo "File $file resolution old - $resolution_old and resolution new - $resolution_new"
        fi
    done < files.txt
done
