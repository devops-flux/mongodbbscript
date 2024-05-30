MongoDB Full Backup Script

This script automates the process of creating a full backup of a MongoDB replica set. It utilizes the mongodump and mongorestore tools to create and restore backups. The script has been tested with MongoDB 6.0 and above 

Prerequisites:


MongoDB replica set with version 6.0 or above.
mongodump, mongoshell  and mongorestore tools installed. 
bash shell (tested with version 5.0.17)
p7zip-full packages should be installed if not can be installed by following commands in Ubuntu 20.04
apt install p7zip-full

To run the script, follow these steps:

Download the mongodbfullbackupwithdbcredentials.sh script to your local machine.
Open a terminal window and navigate to the directory where the mongodbfullbackupwithdbcredentials.sh script is located.
Make the script executable by running the command chmod +x mongodbfullbackupwithdbcredentials.sh.

 if you want to  run script with username password port host then follow  below commands and modify based on your username password host and port
./mongodbfullbackup.sh <username> <password> <host> <port>
 for example  below commands 
 ./mongodbfullbackup.sh root  samplepassword localhost 27017

The script will perform the following actions:

Dump the data from the MongoDB replica set using the mongodump tool.
Create a tarball of the dumped data .7Z FORMAT

If you encounter any issues or errors during the backup process, please provide the error messages and log information to help diagnose the problem.

The mongodbfullbackupwithdbcredentials.sh script has been tested with the following MongoDB version and bash version:

MongoDB 6.0.0
bash 5.0.17
The test results for this script are:

The backup script has passed the backup test.
The backup data has been successfully restored.
The MongoDB replica set is functioning properly after the backup and restore process.
For further assistance, please feel free to reach out.

Remember to replace USERNAME, PASSWORD ,HOST and PORT with your actual MongoDB credentials. Also, make sure to replace the backup and storage directory paths with your actual backup storage directory.
