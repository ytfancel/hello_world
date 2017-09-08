#!/bin/bash
#$1:srcdir  $2:dstpath
function ergodic(){
local target=$2
for file in ` ls -a $1`
do
        echo "file------------$file"
        if [ ${file} != "." ]&&[ ${file} != ".." ]
        then
                if [ -d $1$file ]                               
                then
                        target=${2}${file}"/"
                        echo $target
                        mkdir -p $target
                        ergodic $1$file"/" $target
                else
                        local path=$1$file
                        local rawfilename=$2$file                          

                        if [ "${path##*.}"x = "c"x ]||[ "${path##*.}"x = "java"x ]||[ "${path##*.}"x = "cpp"x ]||[ "${path##*.}"x = "cc"x ]
                        then
                                local targetfile=${rawfilename}.txt      
                                echo $targetfile
                                touch $targetfile
                                cat $path > $targetfile
                                mv $targetfile $rawfilename
                        else
                                cp -af $path $rawfilename
                        fi
                fi
        fi

done
}

echo "hello Wonderful World--------------start"
srcpath=$1
lastchar=${srcpath:((${#srcpath} - 1))}
echo $lastchar
if [ "$lastchar" != "/" ] 
then
        srcpath=$srcpath"/"
fi

dstpath=$srcpath"../target/"

echo $srcpath
echo $dstpath
mkdir -p $dstpath
ergodic $srcpath  $dstpath
if [ -d $dstpath ] 
then
        newpath = ${$srcpath%?}"-new"
        mv $dstpath $newpath 
fi
