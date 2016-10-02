#!/bin/bash

dir="img/photos/*"

for f in $dir
do
    echo $f
    f=${f##*/}
    ./Load_gallery.sh $f
done
exit
