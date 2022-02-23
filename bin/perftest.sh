#!/bin/bash

function usage() {
echo "Usage:  $0 url count"
echo "Example: $0 http://mytestserver.net:81/hello.html 10";
}

if [ $# -ne 2 ]; then
usage;
exit;
fi

host=$1
count=$2

let i=$count-1
tot=0
while [ $i -ge 0 ];
do
res=`curl -w "$i: %{time_total} %{http_code} %{size_download} %{url_effective}\n" -o "/dev/null" -s ${host}`
echo $res
val=`echo $res | cut -f2 -d' '`
tot=`echo "scale=3;${tot}+${val}" | bc`
let i=i-1
./usleep 1000
done

avg=`echo "scale=3; ${tot}/${count}" |bc`
echo "   ........................."
echo "   AVG: $tot/$count = $avg"
