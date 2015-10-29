#!/bin/bash

if [ $# -ne 1 ]
then
    echo -e "Usage: \n $0 FOLDER_NAME"
    exit
fi

dir="img/photos/$1"
titleFile="$dir/title"
file="./$1.html"
photos="$dir/*"
template="Detail_photos.html"

file=${file##*/}

title=$(head -n 1 $titleFile)

cp $template $file

sed -i "s@_title_@$title@g" $file

htmlTemplate="<div class=\"work\">\n\t\t\t<a href=\"_photo_\">\n\t\t\t\t<img src=\"_thumb_\" class=\"media\" alt=\"\"/>\n\t\t\t\t<div class=\"caption\">\n\t\t\t\t\t<div class=\"work_title\">\n\t\t\t\t\t\t<h1>_title_</h1>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</a>\n\t\t</div>\n"

portPhotos="$dir/Port*"
thumb="$dir/thumb.jpg"

next="none"
cur="none"

for f in $portPhotos
do
    if [ ${f: -4} == ".png" ] || [ ${f: -4} == ".jpg" ]
    then
        echo "Processing $f..."
        if [ $cur != "none" ]
        then
            ./Load_photo.sh $next $cur $f $file $titleFile
            next=$cur
        fi
        
        cur=$f
        
        href=${f##*/}
        href="${file::-5}_${href::-4}.html"
        echo $href
        
        element="${htmlTemplate/_thumb_/$f}"
        element="${element/_title_/""}"
        element="${element/_photo_/"$href"}"
        
        sed -i "61i$element" $file
    fi
done



for f in $photos
do
    if [ ${f: -4} == ".png" ] || [ ${f: -4} == ".jpg" ] 
    then
        if [[ "$f" != $portPhotos ]] && [ "$f" != $thumb ]
        then
            echo "Processing $f..."
            if [ $cur != "none" ]
            then
                ./Load_photo.sh $next $cur $f $file $titleFile
                next=$cur
            fi
            cur=$f
            
            href=${f##*/}
            href="${file::-5}_${href::-4}.html"
            echo $href
            
            element="${htmlTemplate/_thumb_/$f}"
            element="${element/_title_/""}"
            element="${element/_photo_/"$href"}"
            
            sed -i "61i$element" $file
        fi
    fi
done

./Load_photo.sh $next $cur "none" $file $titleFile

echo $title

htmlTitle="<li><h1 class=\"title\">$title</h1></li>"

sed -i "56i$htmlTitle" $file

exit