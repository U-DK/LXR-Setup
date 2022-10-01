# LXR-Setting instruction

### Official site: https://lxr.sourceforge.io

This introduction will help you install LXR on your Ubuntu.
Because of the indexing which is a time-consuming job, I choose kernel-v1.0. It's small so that we can index that fast. Of course you can change it to any version like ***v6.0-rc6*** which is the latest version when I am writing this.

## Environment overview
***Test environment: Ubuntu 22.0.4***  
***LXR version: 2.3.6***  
***Linux kernel version: v1.0***  
***Local server: Apache***  
***Database: MySQL***  
***Index searching: Glimpse-4.18.7***  

## Important notice
Your default mysql root password would be "password"(without quotation marks).

## Components
***Perl***  
***GCC***  
***Ctags(Exuberant)***  
***Glimpse***  
***MySQL***  
***Apache***  
***LXR***  
> http://sourceforge.net/projects/lxr/files/stable/lxr-2.3.6.tgz  
  
***Linux kernel source-code***  
> https://www.kernel.org/pub/linux/kernel/v1.0/linux-1.0.tar.xz  
  
## Packages name(Names may vary along with the version updates)
***build-essential***  
***exuberant-ctags***  
***glimpse***  
***mysql-server***  
***apache2***  
***libapache2-mod-perl2***  
***libdbi-perl***  
***libdbd-mysql-perl***  
***libfile-mmagic-perl***  
***libmysqlclient-dev***  

## Steps
1. Use `sudo apt-get update` to update repository.
2. Then `sudo apt-get update install <package name>` to install all of the packages mentioned above.
3. An error will occur when you run the `mysql_secure_installation` script without some further configuration. So we have to fix this first. For more details, visit https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-22-04
```bash
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
printf '%s\n' "password" n n n n y | sudo mysql_secure_installation
```
4. Here you have a choice to make because of the access permission problem with `Apache` later.  
* If you choose to install into `/usr/local/share`(Because Apache can access to this folder), then you have to put `sudo` before every command thereafter except `cd`.  
* If you choose to install into `/home/<your username>`(Your home but Apache has permission issues there at the very beginning), then you don't have to put `sudo` but an extra step you need to do in the end.
5. Here I put those commands without `sudo` as we are installing LXR in the home directory. So we `cd`, which brings us into our home root: `/home/<your username>`. 
7. `mkdir LXR`. We use this `LXR` folder as our LXR root.
8. Download LXR package. We use version `2.3.6` to build. 
```bash 
cd LXR
wget http://sourceforge.net/projects/lxr/files/stable/lxr-2.3.6.tgz
tar xvf lxr-2.3.6.tgz
```
8. Download linux kernel. We use version `v1.0` considering the time consuming process later. You can replace it with any version you like, but don't forget changing the decompressed name to you version: `vx.xx.xxx`. We will put all of our kernel source in `linux-source`.
```bash 
mkdir linux-source
cd linux-source
wget https://www.kernel.org/pub/linux/kernel/v1.0/linux-1.0.tar.xz
tar xvf linux-1.0.tar.xz
mv linux v1.0
```
9. Prepare to config LXR.
```bash
cd
cd /usr/local/share
cd LXR/lxr-2.3.6/
sudo ./scripts/configure-lxr.pl -vv
```
10. Use `https://lxr.sourceforge.io/en/1-0-InstallSteps/1-0-install3config.php` as a reference.  
Caution here:  
* `--- Directory for glimpse databases? >` in this stage(Need absolute path):  
If you choose to install LXR into `/usr/local/share` at step 3, then here should be `/usr/local/share/LXR/<your DIY dir>`(Because we mkdir LXR before).  
If you choose to install LXR into your home path at step 3, then here should be `/home/<your username>/LXR/<your DIY dir>`.  
* `--- Source directory? (e.g. /home/myself/project-tree) >` in this stage(Need absolute path):  
Again, if `/usr/local/share`, then `/usr/local/share/LXR/linux-source`, if home path, then `/home/<your username>/LXR/linux-source`.  
* `--- Version name? (hit return to stop) >` in this stage:  
you should keep the same as the folder name you changed in `linux-source` directory. You can put as many as you can, if you want to stop, just hit `return`.  
* `*** Configuring data storage` in this stage:  
just remember the dbname, username and password you set for the lxr database.
11. Initialize lxr database, you need to enter the password we set before: "password"(without quotation marks).
```bash
./custom.d/initdb.sh
```
12. Copy configuration file to lxr directory.
```bash
cp custom.d/lxr.conf .
```
13. Config Apache here.(Need sudo anyway)
```bash
sudo cp custom.d/apache-lxrserver.conf /etc/apache2/conf-available
sudo a2enconf apache-lxrserver.conf
sudo a2dismod mpm*
sudo a2enmod mpm_worker
sudo systemctl reload apache2
sudo systemctl restart apache2
```
14. Now we are going to have the most time-consuming job here: Indexing. We should index and reference those kernel sources. `--version=` accepts the version name we set before, remember the step 8? If you have a different one, just put it in. Just wait until the indexing is done.
```bash
./genxref --url=http://localhost/lxr --version=v1.0
```
15. Those who install LXR into `/usr/local/share`, you may open your browser and visit http://localhost/lxr/source. Again, don't forget put `sudo` before your commands. If you chose to install LXR into your home path like me, then we have the last one to do.
```bash
sudo chgrp www-data /home/<your username>
sudo chmod g+x /home/<your username>
```
16. OK! We are done! Just open your browser and enjoy!
17. 
