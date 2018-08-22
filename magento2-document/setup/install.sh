# create project
composer create-project --repository-url=https://repo.magento.com/magento/project-community-edition
composer create-project --stability=stable --no-install magento/project-community-edition magento

# create file auth.json
# get key : https://marketplace.magento.com/customer/accessKeys/
{
   "http-basic": {
      "repo.magento.com": {
         "username": "1f18d0a0d048ba904712cfa440dada4b",
         "password": "80c3a56d4db3ac022abac9ba4009c146"
      }
   }
}

# permission
cd <your Magento install dir> 

find . -type f -exec chmod 644 {} \;                        # 644 permission for files

find . -type d -exec chmod 755 {} \;                        # 755 permission for directory 

find ./var -type d -exec chmod 777 {} \;                # 777 permission for var folder    

find ./pub/media -type d -exec chmod 777 {} \;

find ./pub/static -type d -exec chmod 777 {} \;

chmod 777 ./app/etc

chmod 644 ./app/etc/*.xml

chown -R :<web server group> .

chmod u+x bin/magento

# check nginx config

# http://localhost/setup/index.php

# deploy sampledata
php bin/magento sampledata:deploy

# setup upgrade
php bin/magento setup:upgrade

# setup compile
php bin/magento setup:di:compile

