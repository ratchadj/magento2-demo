
php bin/magento deploy:mode:set developer

php /var/www/html/magento2/bin/magento setup:upgrade

php /var/www/html/magento2/bin/magento setup:di:compile

php /var/www/html/magento2/bin/magento setup:static-content:deploy en_US -f

php /var/www/html/magento2/bin/magento cache:flush

php /var/www/html/magento2/bin/magento indexer:reindex