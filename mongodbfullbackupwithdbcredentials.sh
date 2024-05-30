#!/usr/bin/bash

#######################################################################################################################################
#                                                  DEVELOPED BY ---   DEVOPSFLUX.COM                                                  #
#                                                  VERSION      ---   0.0.1                                                           #
#                                                  DATE         ---   30-MAY-2024                                                     #
#                                                  LANGUGE      ---   BASH                                                            #
#                                                  TYPE         ---   SHELL SCRIPT                                                    # 
#######################################################################################################################################

function checkexistingbackupfolderandcreatenew() {

    backupfolder=/opt/bkp-$(date +%y%m%d)

    if [ -d $backupfolder ]; then

        echo "you can not take backup, ${backupfolder} folder  is already there, please check"

        exit 1

    else

        mkdir ${backup_dir}
        if [ $? -eq 0 ]; then
            echo "${backup_dir} was created  successfully"
        else
            echo "${backup_dir} was failed. to created"
            exit 1
        fi

    fi

}

function checkexistingbackupfilenameandcreatenew() {

    compressedfile=/opt/bkp-$(date +%y%m%d).7z

    if [ -f $compressedfile ]; then

        echo "you can not compress backupfolder,  $compressedfile  is already there, please check"

        exit 1

    else

        backupfolder=/opt/bkp-$(date +%y%m%d)

        if [ -d $backupfolder ]; then

            7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on ${compressedfile} ${backupfolder}/

            if [ $? -eq 0 ]; then
                echo " ${backupfolder} compression is    completed successfully"
            else
                echo " ${backupfolder} compression is  failed  "
                exit 1
            fi

        fi

    fi
}

function databasedump() {

   if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ]; then
        echo "All input parameters must have a value"
       exit 1
   fi

    backup_dir="/opt/bkp-$(date +%y%m%d)"
    db_user_name=$1
    db_password=$2
    db_host=$3
    db_port=$4

    checkexistingbackupfolderandcreatenew

    if [ -d "$backup_dir" ]; then

        for DATABASE_NAME in $(mongosh --quiet --eval "show dbs" | awk {'print $1'}); do
            
            mongodump --username ${db_user_name} --password ${db_password} --host ${db_host} --db ${DATABASE_NAME} --port ${db_port} --out ${backup_dir}

            if [ $? -eq 0 ]; then
                echo "database ${DATABASE_NAME}  dump for  was completed successfully."
            else
                echo "database ${DATABASE_NAME}  dump was failed. so removing directory  ${backup_dir}"
                rm -rf ${backup_dir}
                if [ $? -eq 0 ]; then
                    echo "${backup_dir} was  successfully removed"
                else
                    echo "${backup_dir} was failed to remove, remove it manually"
                    exit 1
                fi
                exit 1
            fi

        done

        checkexistingbackupfilenameandcreatenew

    else
        echo "$backup_dir does not exist"
        exit 1
    fi

}



function main() {

databasedump

}

main

#####################################################################
# if you want to  run script with username password port host then follow  below commands and modify based on your username password host and port
# ./mongodbfullbackup.sh <username> <password> <host> <port>
# for example  below commands 
# ./mongodbfullbackup.sh root  samplepassword localhost 27017
