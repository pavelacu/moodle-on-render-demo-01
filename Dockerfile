FROM php:8.1-apache

# Instala extensiones necesarias para Moodle
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql gd zip

# Clona Moodle
RUN git clone -b MOODLE_401_STABLE https://github.com/moodle/moodle.git /var/www/html

# Establece permisos
RUN chown -R www-data:www-data /var/www/html

# Copia tu config.php si ya lo tienes
# COPY config.php /var/www/html/config.php