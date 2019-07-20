#!/bin/bash

set -x

sed -i -e "s/’/\'/g" -e "s/–/-/g" -e "s/“/\"/g" -e "s/”/\"/g" $1.html

docker run --name weasy -d rstmpw/weasyprint
docker cp codeblock_wrap.css weasy:/tmp/codeblock_wrap.css
docker exec -i weasy weasyprint -v -f pdf -s /tmp/codeblock_wrap.css '-' '-' >|$1.pdf <$1.html
docker rm -f weasy