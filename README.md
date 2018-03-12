# Wordpress Box
A simple Vagrant based development environment for Wordpress themes.

### Setup

(All commands and references are from the project directory unless otherwise specified.)

1) Ensure Virtualbox and Vagrant are installed.
2) Clone this directory into the desired location of your dev environment.
4) In `/config/wordpress`, ensure there is a wordpress tar file for the box to install, available on their site.  (This allows you to use the newest version of Wordpress.)
5) Modify line 41 in `/config/bootstrap.sh` to include the name of the Wordpress tar from Step 3.
6) `$ vagrant up --provision`
7) Add the following to your hosts file: `192.168.33.10 blog.local` and `192.168.33.10 www.blog.local`
8) Navigate to `http://www.blog.local` in your browser (include the protocol), you should see the Wordpress setup screen if done correctly.

### Re-installation
1) Remove `setup_apache_complete`, `setup_db_complete`, and `setup_wordpress_complete` from `/logs`.
2) `$ vagrant destroy`
3) `$ vagrant up --provision`

### Notes
* The MySQL database on the VM uses 'root' for both its username and password.  (Obviously this project is only for LOCAL development.)
* When restoring content from a previous blog, the suggested method is to use Wordpress's Import and Export options.  The media library can be copied over manually, though there are Wordpress plugins that do exactly this.