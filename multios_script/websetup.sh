#!/bin/bash
#artifact from tooplate website
PACKAGE_LINK="https://www.tooplate.com/download/2112_brunch"
PACKAGE_NAME="2112_brunch"

echo "login to server"
#checking whether the machine is ubuntu or centos
        yum --help &> /dev/null
# $? will return 0 if it is centos 
        if [ $? == 0 ]
        then
                PACK="httpd unzip wget"
                echo "Centos"
                sudo yum install $PACK
                sudo systemctl start httpd
                mkdir /tmp/webset -p
                cd /tmp/webset
                wget $PACKAGE_LINK
#renaming the file to .zip because,
#the file is downloading doesn't arrived at zip fromat
                sudo mv $PACKAGE_NAME $PACKAGE_NAME.zip
                unzip $PACKAGE_NAME.zip
                sudo cp -r $PACKAGE_NAME/* /var/www/html
                sudo systemctl restart httpd
        else
                echo "Ubuntu"
                PACK="apache2 unzip wget"
                apt update
                sudo apt install $PACK
                sudo systemctl start apache2
                mkdir /tmp/webset -p
                cd /tmp/webset
                wget $PACKAGE_LINK
                sudo mv $PACKAGE_NAME $PACKAGE_NAME.zip
                unzip $PACKAGE_NAME
                sudo cp -r $PACKAGE_NAME/* /var/www/html
                sudo systemctl restart apache2
        fi
