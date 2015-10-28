#!/bin/bash

files="img/photos/*/*.jpg"
ports="img/photos/*/Port*.jpg"

for f in $files
do
    if [[ "$f" != $ports ]]
    then
        echo $f
        mogrify -resize 1920x1280! $f
    fi
done

for f in $ports
do
    echo $f
    mogrify -resize 1920x1280! $f
done



exit