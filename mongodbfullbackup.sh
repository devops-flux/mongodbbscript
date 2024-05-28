#!/usr/bin/bash
set -x 

function  checkbackupfolder(){

backupfolder=/opt/bkp-$(date +%y%m%d)

if [ -d $backupfolder ]
then 

echo   "you can not take backup, ${backupfolder} folder  is already there, please check"

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


function checkbackupfilename() {

compressedfile=/opt/bkp-$(date +%y%m%d).7z

if [ -f $compressedfile ]
then 

echo   "you can not compress backupfolder,  $compressedfile  is already there, please check"

exit 1

else 


backupfolder=/opt/bkp-$(date +%y%m%d)

if [ -d $backupfolder ]
then

7z a -t7z -m0=lzma2 -mx=9 -mfb=64 -md=32m -ms=on ${compressedfile}   ${backupfolder}/

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

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ];
 then
  echo "All input parameters must have a value"
  exit 1
fi

backup_dir="/opt/bkp-$(date +%y%m%d)"
db_user_name=$1
#db_password=$2
db_host=$2
db_port=$3



checkbackupfolder


if [ -d "$backup_dir" ]; then

for DATABASE_NAME in $(mongosh --quiet --eval "show dbs" |awk {'print $1'}); 
do
 
mongodump   --username "" --password "" --host ${db_host} --db ${DATABASE_NAME}  --port ${db_port} --out ${backup_dir}
 
if [ $? -eq 0 ]; then
     echo "database ${DATABASE_NAME}  dump for  was completed successfully."
     else
     echo "database ${DATABASE_NAME}  dump was failed. so removing directory  ${backup_dir}"
     rm -rf ${backup_dir}
     if [ $? -eq 0 ]; then
     echo "${backup_dir} was  successfully removed"
     else
     echo "${backup_dir} was failed to remove remove it manually"
     exit 1
     fi
     exit 1
fi

done
    

checkbackupfilename

else 
   echo "$backup_dir does not exist"
   exit 1 
fi 

}

databasedump $1 $2 $3 
