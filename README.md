# LXR-Setting instruction

### Official site: https://lxr.sourceforge.io

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
If you install into `/usr/local/share`(Because Apache can access to this folder), then you have to put `sudo` before every command thereafter except `cd`.  
If you install into `/home/<your username>`(Your home), then you don't have to put `sudo` but an extra step you would do at last.
4. Here I put those command as we are installing LXR in your home directory. So we `$cd`, which brings us into our home root: `/home/<your username>`.
5. `$mkdir LXR`. We use this `LXR` folder as our LXR root.
6. Download LXR package. We use version `2.3.6` to build. 
```bash 
$cd LXR
$wget http://sourceforge.net/projects/lxr/files/stable/lxr-2.3.6.tgz
$tar xvf lxr-2.3.6.tgz
```
7. Download linux kernel. We use version `v1.0` considering the time consuming process later. You can replace it with any version you like, but don't forget changing the decompressed name to you version: `vx.xx.xxx`.
```bash 
mkdir linux-source
cd linux-source
wget https://www.kernel.org/pub/linux/kernel/v1.0/linux-1.0.tar.xz
tar xvf linux-1.0.tar.xz
mv linux v1.0
```
8. Prepare to config LXR.
```bash
cd
cd /usr/local/share
cd LXR/lxr-2.3.6/
sudo ./scripts/configure-lxr.pl -vv
```
9. Use `https://lxr.sourceforge.io/en/1-0-InstallSteps/1-0-install3config.php` as a reference.
