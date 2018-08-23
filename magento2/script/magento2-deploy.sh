
php /var/www/html/bin/magento deploy:mode:set production

php /var/www/html/bin/magento setup:upgrade

# php /var/www/html/bin/magento setup:di:compile

php /var/www/html/bin/magento setup:static-content:deploy
