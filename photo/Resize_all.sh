#!/bin/bash

if [ $# -eq 0 ]
then
    files="img/photos/*/*.jpg"
    ports="img/photos/*/Port*.jpg"
else
    files="img/photos/$1/*.jpg"
    ports="img/photos/$1/Port*.jpg"
fi


for f in $files
do
    if [[ "$f" != $ports ]] && [[ "$f" != "thumb.jpg" ]]
    then
        echo $f
        mogrify -resize 1920x1280! $f
    fi
done

for f in $ports
do
    echo $f
    mogrify -resize 1280x1920! $f
done



exit