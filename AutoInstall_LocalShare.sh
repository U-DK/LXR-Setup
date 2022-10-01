#!/bin/bash
echo “This script will help you install LXR on Ubuntu, please read README.txt before starting, especially your future mysql root password.”
read -p “Ready?[y/n]” ans
if [[ $ans != 'y' && $ans != 'Y' ]]; then
echo "Exit!"
exit 1
fi 
sudo apt-get update
echo "Y" | sudo apt-get install build-essential
echo "Y" | sudo apt-get install exuberant-ctags
echo "Y" | sudo apt-get install glimpse
printf '%s\n' y y y y | sudo apt-get install exuberant-ctags mysql-server apache2 libapache2-mod-perl2
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
printf '%s\n' "password" n n n n y | sudo mysql_secure_installation
printf '%s\n' y y y y | sudo apt-get install libdbi-perl libdbd-mysql-perl libfile-mmagic-perl libmysqlclient-dev
echo "packages finished"
cd
cd /usr/local/share
sudo mkdir LXR
cd LXR
sudo wget http://sourceforge.net/projects/lxr/files/stable/lxr-2.3.6.tgz
sudo tar xvf lxr-2.3.6.tgz
sudo mkdir linux-source
cd linux-source
sudo wget https://www.kernel.org/pub/linux/kernel/v1.0/linux-1.0.tar.xz
sudo tar xvf linux-1.0.tar.xz
sudo mv linux v1.0
cd
cd /usr/local/share
cd LXR/lxr-2.3.6/
sudo ./scripts/configure-lxr.pl -vv
sudo ./custom.d/initdb.sh
sudo cp custom.d/lxr.conf .
sudo cp custom.d/apache-lxrserver.conf /etc/apache2/conf-available
sudo a2enconf apache-lxrserver.conf
sudo a2dismod mpm*
sudo a2enmod mpm_worker
sudo systemctl reload apache2
sudo systemctl restart apache2
sudo ./genxref --url=http://localhost/lxr --version=v1.0
echo "All finished! Now try to visit http://localhost/lxr"
