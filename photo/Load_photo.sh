#!/bin/bash

if [ $# -ne 5 ]
then
    echo -e "Usage: \n $0 PREV_PIC_NAME PIC_NAME NEXT_PIC_NAME TITLE"
    exit
fi

echo "next: $1, cur: $2, prev: $3, up: $4, title: $5"

template="Single_photo.html"

fileSuffix=${2##*/}
file="${4::-5}_${fileSuffix::-4}.html"

title=$(head -n 1 $5)

if [ $1 != "none" ]
then
    next=${1##*/}
    next="${4::-5}_${next::-4}.html"
else
    next="#"
fi

if [ $3 != "none" ]
then
    prev=${3##*/}
    prev="${4::-5}_${prev::-4}.html"
else
    prev="#"
fi

echo $file

cp $template $file

sed -i "s@_next_@$next@g" $file
sed -i "s@_image_@$2@g" $file
sed -i "s@_prev_@$prev@g" $file
sed -i "s@_parent_@$4@g" $file
sed -i "s@_title_@$title@g" $file

htmlTitle="<li><h1 class=\"title\">$title</h1></li>"

sed -i "22i$htmlTitle" $file

exit