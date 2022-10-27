# #!/usr/bin/env bash
# sed -i "s/Listen 80/Listen ${PORT:-80}/g" /etc/apache2/ports.conf
# sed -i "s/:80/:${PORT:-80}/g" /etc/apache2/sites-enabled/*

# composer install --no-plugins --no-scripts

# php artisan migrate
# php artisan key:generate
# php artisan db:seed

# apache2-foreground

#!/bin/bash

composer install  --no-interaction

php artisan migrate 
php artisan key:generate 
php artisan cache:clear
php artisan config:clear
php artisan route:clear


php artisan serve  --host=0.0.0.0  
