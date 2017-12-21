# install missing dependency
sudo apt-get update
sudo apt-get install -y php7.0-xml php7.0-common

# self-update composer
sudo /usr/local/bin/composer self-update

# use composer to update latest dev environemt
cd /var/www/public
composer install --no-progress --no-dev --prefer-dist

sudo service apache2 restart
