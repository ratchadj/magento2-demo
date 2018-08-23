#!/bin/sh
# variable
FOLDER_NAME="magento2"
BACKEND_FRONTNAME="admin"
KEY="admin"
SESSION_SAVE="files"
#DB
DB_HOST="mysql"
DB_NAME="magento2"
DB_USER="root"
DB_PASS="root"
#URL
BASE_URL="http://localhost/"
SECURE_BASE_URL="https://localhost/"
#ADMIN
ADMIN_USER="admin"
ADMIN_PASS="Zaqwsx123!"
ADMIN_EMAIL="ratchada@acommerce.asia"
ADMIN_SURNAME="Ratchada"
ADMIN_LASTNAME="Jududom"

# php bin/magento setup:install --backend-frontname=$BACKEND_FRONTNAME --key=$KEY --session-save=$SESSION_SAVE --db-host=$DB_HOST --db-name=$DB_NAME --db-user=$DB_USER --db-password=$DB_PASS --base-url=$BASE_URL --base-url-secure=$SECURE_BASE_URL --admin-user=$ADMIN_USER --admin-password=$ADMIN_PASS --admin-email=$ADMIN_EMAIL --admin-firstname=$ADMIN_SURNAME --admin-lastname=$ADMIN_LASTNAME

echo "setup magento2 process starting...";

# create project by url
# composer create-project --repository-url=https://repo.magento.com/magento/project-community-edition
# create project by stability
composer create-project --stability=stable --no-install magento/project-community-edition $FOLDER_NAME
chmod 777 ./$FOLDER_NAME
echo "setup magento2 process create project finished";

# create file auth.json
# Go to this link to get access keys : https://marketplace.magento.com/customer/accessKeys/
echo '{
   "http-basic": {
      "repo.magento.com": {
         "username": "1f18d0a0d048ba904712cfa440dada4b",
         "password": "80c3a56d4db3ac022abac9ba4009c146"
      }
   }
}' >> ./$FOLDER_NAME/auth.json 2>&1
chmod u+x ./$FOLDER_NAME/auth.json;
echo "setup magento2 process add auth.json finished";

cd $FOLDER_NAME

# composer install
composer install

# permission
echo "setup magento2 process permission starting...";

find . -type f -exec chmod 644 {} \;                        # 644 permission for files

find . -type d -exec chmod 755 {} \;                        # 755 permission for directory 

find ./var -type d -exec chmod 777 {} \;                    # 777 permission for var folder    

find ./pub/media -type d -exec chmod 777 {} \;

find ./pub/static -type d -exec chmod 777 {} \;

chmod 777 ./app/etc

chmod 644 ./app/etc/*.xml

# chown -R :<web server group> .

chmod u+x bin/magento

# install sampledata
php bin/magento sampledata:deploy

# composer upgrade
composer upgrade

# install via url please click : http://localhost/setup/index.php
php bin/magento setup:install --backend-frontname=$BACKEND_FRONTNAME --key=$KEY --session-save=$SESSION_SAVE --db-host=$DB_HOST --db-name=$DB_NAME --db-user=$DB_USER --db-password=$DB_PASS --base-url=$BASE_URL --base-url-secure=$SECURE_BASE_URL --admin-user=$ADMIN_USER --admin-password=$ADMIN_PASS --admin-email=$ADMIN_EMAIL --admin-firstname=$ADMIN_SURNAME --admin-lastname=$ADMIN_LASTNAME

php bin/magento deploy:mode:set developer
# setup upgrade
php bin/magento setup:upgrade

# setup compile
php bin/magento setup:di:compile

php bin/magento setup:static-content:deploy
