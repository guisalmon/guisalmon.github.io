#!/bin/bash

files="img/photos/*/thumb.jpg"

for f in $files
do
    echo $f
    mogrify -resize 640x427! $f
done

exit