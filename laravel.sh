#!/bin/bash

# For whatever reason these services aren't started whenever WSL closes.
# Short .sh script to start them. 

valet start
sudo service php7.4-fpm start
sudo service mysql start
