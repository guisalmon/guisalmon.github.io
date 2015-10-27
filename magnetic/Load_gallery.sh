#!/bin/bash

if [ $# -ne 1 ]
then
    echo -e "Usage: \n $0 FOLDER_NAME"
    exit
fi

file="index.html"
dir="img/photos/$1"
thumb="$dir/thumb.jpg"
titleFile="$dir/title"

./Load_details.sh $1 > /dev/null

htmlTemplate="<div class=\"work\">\n\t\t\t<a href=\"_href_\">\n\t\t\t\t<img src=\"_thumb_\" class=\"media\" alt=\"\"/>\n\t\t\t\t<div class=\"caption\">\n\t\t\t\t\t<div class=\"work_title\">\n\t\t\t\t\t\t<h1>_title_</h1>\n\t\t\t\t\t</div>\n\t\t\t\t</div>\n\t\t\t</a>\n\t\t</div>\n"

title=$(head -n 1 $titleFile)
ref="$1.html"

htmlTemplate="${htmlTemplate/_thumb_/$thumb}"
htmlTemplate="${htmlTemplate/_title_/$title}"
htmlTemplate="${htmlTemplate/_href_/$ref}"

echo -e $htmlTemplate

sed -i "51i$htmlTemplate" $file

exit