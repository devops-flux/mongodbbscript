# MongoDB Full Backup Script

This script automates the creation of a full backup for a MongoDB replica set, leveraging the mongodump and mongorestore tools. It's compatible with MongoDB versions 6.0 and later.

## Prerequisites:

MongoDB Replica Set: Ensure you have a running replica set with version 6.0 or above.
Tools: Make sure mongodump, mongoshell, mongorestore, and bash (tested with 5.0.17) p7zip-full are installed.

if p7zip-full is not installed  , install it using sudo apt install p7zip-full.
Usage:
compression creating .7z file 

## Download and Permissions:
Download the script (mongodbfullbackupwithdbcredentials.sh) to your local machine. In your terminal, navigate to the script's directory. Make the script executable:

Bash
chmod +x mongodbfullbackupwithdbcredentials.sh

## Run the Script:
Execute the script, providing your MongoDB credentials (username, password, host, and port) as arguments:

Bash
./mongodbfullbackupwithdbcredentials.sh DBUSERNAME DBPASSWORD DBHOST DBPORT

Example:
Bash
./mongodbfullbackupwithdbcredentials.sh root samplepassword localhost 27017

## Script Actions:

Utilizes mongodump to dump data from the replica set.
Creates a compressed archive (.7z format) of the dumped data using p7zip.


## Testing:

This script has been rigorously tested with:

MongoDB version: 6.0.0
Bash version: 5.0.17

Test results confirm:
Successful backup creation.
Flawless restoration of backup data.
Proper functioning of the MongoDB replica set after backup and restore.

## Support:
Feel free to reach out for further assistance. If you encounter issues, provide the error messages and logs for troubleshooting.
you can reach at me anandrai@devopsflux.com

## Customization:

Replace (dbusername, dbpassword, dbhost, and dbport)  with your actual MongoDB credentials.
Modify backup and storage directory paths within the script itself.

Security: This script directly includes credentials in the command line. For enhanced security, consider environment variables or a configuration file for storing credentials.

Retention: Implement a strategy for retaining and rotating backups to manage storage usage.
