#!/bin/bash
mkdir -p "${1}"/scripts


function getValueFromConfig() {
    echo `grep ${1} config.conf | cut -d '=' -f 2`
}


for x in $(ls "${1}/aquatone/html/")
do

        END_POINTS=$(cat "${1}/aquatone/html/$x" | grep -Eoi "src\s*=\s*[\'\"]?[^>]+></script>" |grep -Eoi "[\'\"\/].*js"|sed "s/\"//g"| sed "s/\'//g")
        for end_point in $END_POINTS
        do
                URL=$end_point

                len=$(echo $end_point | grep "//" | wc -c)
                if [ $len == 0 ]
                then
                        URL=`echo "${x}"|sed "s/__/\:\/\//"|sed "s/_/./g"|sed "s/\.\./~/"|cut -d "~" -f 1`
                        URL=$URL/$end_point
                fi
                
                file=$(basename $end_point)
                mkdir -p "${1}/scriptResponse/$x/"
                curl -k -X GET $URL -L > "${1}/scriptResponse/$x/$file"
                echo $URL >> "${1}/scripts/$x"
        done
done  