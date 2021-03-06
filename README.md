# WSL2-Laravel
WSL2 Laravel setup with SQL. 

This method is setting up Laravel on WSL2 without Docker. However, there is a downside and that is editing the hostfile each time making a new project, in order to reach it. 

## WSL2 (PHP, MySQL, Composer, Valet)
Updatet & Upgrade the wsl

    sudo apt update
    sudo apt upgrade
    
Install php 
  
    sudo apt install php-fpm php-curl php-mbstring php-mysql php-xml php-cli unzip network-manager libnss3-tools jq xsel 

Install mysql server

    sudo apt install mysql-server
    
Install composer (https://getcomposer.org/download/)
  
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
    php composer-setup.php
    php -r "unlink('composer-setup.php');"
    
Move composer.phar into a directory on your PATH.

    sudo mv composer.phar /usr/local/bin/composer
    
Install valet

    composer global require cpriego/valet-linux
    echo 'export PATH="$PATH:$HOME/.config/composer/vendor/bin"' >> ~/.profile
    source ~/.profile
    valet install
    
Create a project
  
    cd ~/.valet/Sites
    valet park
    composer create-project --prefer-dist laravel/laravel appstuff
    
-----

In case of DNS problems, this gentleman found a workaround. <br>
https://github.com/microsoft/WSL/issues/4285#issuecomment-522201021


> 
> 
> My workaround:
> 
>     1. Create a file: `/etc/wsl.conf`.
> 
>     2. Put the following lines in the file
> 
> 
> ```
> [network]
> generateResolvConf = false
> ```
> 
>     1. In a `cmd` window, run `wsl --shutdown`
> 
>     2. Restart WSL2
> 
>     3. Create a file: `/etc/resolv.conf`. If it exists, replace existing one with this new file.
> 
>     4. Put the following lines in the file
> 
> 
> ```
> nameserver 8.8.8.8
> ```
> 
>     1. Repeat step 3 and 4. You will see `git` working fine now.


-----

And that is about it. However, whenever you need to access your created laravel project, you have to add your appname.test, to the host file. Like this:
    
    127.0.0.1 appname.test


## Getting MySQL running and PHP

I have uploaded a bash script that simply starts valet, php & mysql services. The script needs to be run everytime the WSL2 starts, because for whatever reason MySQL do not like to keep being shutdown or something. 

https://github.com/KB885/WSL2-Laravel/blob/main/laravel.sh

## MySQL

    sudo mysql -u root
    
When you have access to MySQL. 

    mysql> use mysql;
    mysql> select User, Host, plugin FROM mysql.user;
    mysql> update user set plugin='mysql_native_password' where user = 'root';
    mysql> flush privileges;
    mysql> exit; 
    
Restart MySQL and you should be good to go. 

    sudo service mysql restart

## Connect to the sql & create your database
I am using Tableplus - https://tableplus.com/

<img src="https://i.imgur.com/STcRdu0.png" style="width:250px;" />















