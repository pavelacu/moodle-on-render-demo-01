FROM php:8.1-apache

# Instalar dependencias necesarias
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

# Clonar Moodle (puedes ajustar versión si deseas otra rama)
RUN git clone -b MOODLE_401_STABLE https://github.com/moodle/moodle.git /var/www/html

# Crear directorio moodledata y ajustar permisos
RUN mkdir -p /var/moodledata && \
    chown -R www-data:www-data /var/moodledata /var/www/html && \
    chmod -R 755 /var/moodledata

# Activar mod_rewrite de Apache
RUN a2enmod rewrite

# Aumentar max_input_vars a 5000 (recomendado por Moodle)
RUN echo "php_value max_input_vars 5000" >> /etc/apache2/apache2.conf

# Establecer el directorio de trabajo
WORKDIR /var/www/html