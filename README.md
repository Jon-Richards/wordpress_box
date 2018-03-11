# Wordpress Box
A simple Vagrant based development environment for Wordpress themes.

### Setup
1) Ensure Virtualbox and Vagrant are installed.
2) Clone this directory into the desired location of your dev environment.
3) In `/config/wordpress`, ensure there is a wordpress tar file for the box to install, available on their site.  (This allows you to use the newest version of Wordpress.)
4) `$ vagrant up --provision`
5) Add the following to your hosts file: `192.168.33.10 blog.local` and `192.168.33.10 www.blog.local`
6) Navigate to `http://www.blog.local`, you should see the Wordpress setup screen if done correctly.
