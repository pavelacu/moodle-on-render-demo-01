# Imagen base con PHP y Apache
FROM php:8.1-apache

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    libonig-dev \
    libxml2-dev \
    libpq-dev \
    mariadb-client \
    && docker-php-ext-install gd zip xml \
    && docker-php-ext-install pdo_pgsql pgsql pdo pdo_mysql

# Clonar Moodle (puedes cambiar la rama si necesitas otra versión)
RUN git clone -b MOODLE_401_STABLE https://github.com/moodle/moodle.git /var/www/html

# Crear directorio para moodledata
RUN mkdir -p /var/moodledata && \
    chown -R www-data:www-data /var/moodledata /var/www/html && \
    chmod -R 755 /var/moodledata

# Activar mod_rewrite de Apache
RUN a2enmod rewrite

# Directorio de trabajo
WORKDIR /var/www/html