#!/usr/bin/env bash

# Sets the 'root' user password to mysql when it's installed.
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get update
sudo apt-get -f install
sudo apt-get install -y apache2
sudo apt-get install -y mysql-server
sudo apt-get install -y php5
sudo apt-get install -y libapache2-mod-php5
sudo apt-get install -y php5-mysqlnd


# ----------  Apache  ---------- #

# Check if a symlink from Apache's public directory to the live directory
# exists, if not, we'll create one.
if [ ! -f /vagrant/logs/setup_apache_complete ];
then
  # Backup the original config files
  sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
  sudo cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.bak
  
  # Copy the config files from the setup directory into apache's
  sudo cp /vagrant/config/apache2/apache2.conf /etc/apache2/apache2.conf
  sudo cp /vagrant/config/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf
  
  sudo service apache2 restart
  touch /vagrant/logs/setup_apache_complete
fi


# ----------  Wordpress  ---------- #

# Unpack the wordpress tar if it hasn't already been done.
if [ ! -f /vagrant/logs/setup_wordpress_unpacked ];
then
  # Unpack the wordpress installation
  tar -xf /vagrant/config/wordpress/wordpress-4.9.4.tar.gz -C /vagrant/live
  touch /vagrant/logs/setup_wordpress_unpacked
fi


# Check if the wordpress database is set up.  If not, create a user for wordpress
# and a database for it to use for the blog.
if [ ! -f /vagrant/logs/setup_db_complete ];
then
    echo "CREATE USER 'wp_user'@'localhost' IDENTIFIED BY 'wordpresspass'" | mysql -uroot -proot
    echo "CREATE DATABASE wordpress" | mysql -uroot -proot
    echo "GRANT ALL ON wordpress.* TO 'wp_user'@'localhost'" | mysql -uroot -proot
    echo "flush privileges" | mysql -uroot -proot
    
    touch /vagrant/logs/setup_db_complete
    
    # If a pre-existing database dump exists, copy it into the new wordpress database.
    if [ -f /vagrant/config/wordpress/initial.sql ];
    then
      mysql -uroot -proot wordpress < /vagrant/config/wordpress/initial.sql
    fi
fi