# Imagen base con PHP y Apache
FROM php:8.1-apache

# Instala extensiones necesarias para Moodle
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
    libmariadb-dev \
    mariadb-client \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql gd zip xml

# Clona Moodle (puedes cambiar la rama a otra versión si lo deseas)
RUN git clone -b MOODLE_401_STABLE https://github.com/moodle/moodle.git /var/www/html

# Crea moodledata y da permisos
RUN mkdir -p /var/moodledata && \
    chown -R www-data:www-data /var/moodledata /var/www/html && \
    chmod -R 755 /var/moodledata

# Habilita mod_rewrite de Apache (requerido por Moodle)
RUN a2enmod rewrite

# Establece el directorio de trabajo
WORKDIR /var/www/html