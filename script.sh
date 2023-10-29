 #!/bin/bash


    
sudo apt-get install -y apache2 git software-properties-common

    # Add Ondřej Surý's PHP repository
    sudo add-apt-repository ppa:ondrej/php
    sudo apt-get update

    # Install PHP 8.1
    sudo apt install php8.1 libapache2-mod-php8.1 php-mbstring php-cli php-bcmath php-json php-xml php-curl php-zip php-pdo php-common php-tokenizer php-mysql


    sudo systemctl enable apache2
    
    sudo systemctl start apache2

   # Install MySQL (you may be prompted to set a root password)
   sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password your_mysql_root_password'
   sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password your_mysql_root_password'
   sudo apt-get install -y mysql-server

   # Install Composer
   curl -sS https://getcomposer.org/installer | php
   mv composer.phar /usr/local/bin/composer
   chmod +x /usr/local/bin/composer

# Create a MySQL database
mysql -u root -p"your_mysql_root_password" -e "CREATE DATABASE your_db_name;"
mysql -u root -p"your_mysql_root_password" -e "CREATE USER 'your_db_user'@'localhost' IDENTIFIED BY 'your_password';"
mysql -u root -p"your_mysql_root_password" -e "GRANT ALL PRIVILEGES ON your_db_name.* TO 'your_db_user'@'localhost';"
mysql -u root -p"your_mysql_root_password" -e "FLUSH PRIVILEGES;"

# Configure Apache
cat > /etc/apache2/sites-available/laravelapp.com.conf << EOF
<VirtualHost *:80>
    ServerAdmin webmaster@laravelapp.com
    DocumentRoot /home/vagrant/app/public
    ServerName laravelapp.com

    <Directory /home/vagrant/app>
        Options Indexes MultiViews
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2enmod rewrite
sudo a2ensite laravelapp.com.conf

# Clone Laravel from GitHub
cd /home/vagrant
git clone https://github.com/laravel/laravel.git laravelapp
cd laravelapp
composer install
# Restart Apache
sudo systemctl restart apache2

echo "Laravel application deployed. Access it via your web browser."

