# FROM php:7.4.24-apache
# LABEL Author="nick.io"

# #install zip, unzip extension, git, mysql-client
# RUN apt-get update --fix-missing && apt-get install -y \
#   default-mysql-client \
#   git \
#   unzip \
#   zip \
#   curl \
#   wget
  
# # Install docker php dependencies
# RUN docker-php-ext-install pdo_mysql mysqli

# # Add config files and binary file and enable webserver
# COPY apache-config.conf /etc/apache2/sites-available/000-default.conf
# COPY start-apache . 
# RUN a2enmod rewrite

# RUN curl -sS https://getcomposer.org/installer |php && mv composer.phar /usr/local/bin/composer

# # Copy application source
# COPY . /var/www
# RUN chown -R www-data:www-data /var/www

# EXPOSE 80

# CMD ["bash", "start-apache.sh"]



FROM php:7.4.30-cli

USER root
WORKDIR  /var/www/html

RUN apt-get update && apt-get install -y \
    libpng-dev \
    zlib1g-dev \
    libxml2-dev \
    libzip-dev \
    libonig-dev \
    zip \
    curl \
    unzip \
    && docker-php-ext-configure gd \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install zip \
    && docker-php-source delete

COPY . .

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ENTRYPOINT [  "bash", "start-apache.sh" ]