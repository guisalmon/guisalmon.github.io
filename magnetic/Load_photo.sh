#!/bin/bash

if [ $# -ne 4 ]
then
    echo -e "Usage: \n $0 PREV_PIC_NAME PIC_NAME NEXT_PIC_NAME"
    exit
fi

echo "next: $1, cur: $2, prev: $3, up: $4"

template="Single_photo.html"

fileSuffix=${2##*/}
file="${4::-5}_${fileSuffix::-4}.html"

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

exit