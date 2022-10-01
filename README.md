# LXR-Setting instruction


This introduction will help you install LXR on your Ubuntu.
Because of the indexing which is a time consuming job, I choose kernel-v1.0. It's small so that we can index that fast.

## Environment reference
***Test environment: Ubuntu 22.0.4***  
***LXR version: 2.3.6***  
***Linux kernel version: v1.0***  
***Local server: Apache***  
***Database: MySQL***  
***Index searching: Glimpse-4.18.7***  

## Important Notice
Your mysql root password is "password"(without quotation marks).

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
2. Then `sudo apt-get update install <package name>` to install all of the packages above.
3. Here you have a choice to make because of the access permission problem with `Apache` later.  
###If you install into `/usr/local/share`(Because Apache can access to this folder), then you have to put `sudo` before every command thereafter except `cd`.  
###If you install into `/home/<your username>`(Your home), then you don't have to put `sudo` but an extra step you would do at last.
4. Here I put those command as we are installing LXR in your home directory.
5. 
