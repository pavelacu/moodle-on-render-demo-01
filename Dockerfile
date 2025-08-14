# Imagen base con PHP 8.1 y Apache
FROM php:8.1-apache

# Instalar dependencias del sistema necesarias para extensiones de PHP y Moodle
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
    libicu-dev \
    libexif-dev \
    && docker-php-ext-install \
        gd \
        zip \
        xml \
        intl \
        exif \
        soap \
        pdo_pgsql \
        pgsql \
        pdo \
        pdo_mysql \
        mbstring

# Clonar Moodle (ajusta la rama si deseas otra versión)
RUN git clone -b MOODLE_401_STABLE https://github.com/moodle/moodle.git /var/www/html

# Crear el directorio moodledata y establecer permisos correctos
RUN mkdir -p /var/moodledata && \
    chown -R www-data:www-data /var/moodledata /var/www/html && \
    chmod -R 755 /var/moodledata

# Eliminar archivo de mantenimiento si quedó bloqueado en una instalación previa
RUN rm -f /var/moodledata/climaintenance.html

# Activar módulo rewrite de Apache (requerido por Moodle)
RUN a2enmod rewrite

# Aumentar max_input_vars como recomienda Moodle
RUN echo "php_value max_input_vars 5000" >> /etc/apache2/apache2.conf

# Establecer el directorio de trabajo
WORKDIR /var/www/html