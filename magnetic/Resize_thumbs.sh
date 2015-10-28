#!/bin/bash

files="img/photos/*/thumb.jpg"

for f in $files
do
    echo $f
    mogrify -resize 1920x1280! $f
done

exit