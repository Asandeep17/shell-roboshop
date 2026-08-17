
#!/bin/bash

set -e 
  trap 'echo "There is an Error in $LINENO < Command :$BASH_COMMAND"' ERR


USERID=$(id -u)

LOGS_FOLDER="/var/log/shell-roboshop"
LOGS_FILE="$LOGS_FOLDER/$0.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then 
echo -e " $R please run this script with root user access $N" | tee -a $LOG_FILE
exit 1

fi

mkdir -p $LOGS_FOLDER




VALIDATE(){
    if [ $1 -ne 0 ]; then 
    echo -e "$2 ...$R FAILURE $N " |tee -a $LOG_FILE
    exit 1 
    else 
        echo -e "$2 ... $G SUCCESS $N" |tee -a $LOG_FILE
        fi

}
   


   cp mongo.repo /etc/yum.repos.d/mongo.repo
   VALIDATE $? "copying mongo repo"
   dnf install mongo-org -y
   VALIDATE $? "installing mongodb server"
   systemctl enable mongod
VALIDATE $?"enable mongodb "
systemctl start mongod 
VALIDATE $?" start mongodb"
 sed -i 's/127.0.0.1/0.0.0.0/g' etc/mongod.conf
 VALIDATE "allowing remote connection"
 systemctl restart mongodb
 VALIDATE "restart the mongodb"
