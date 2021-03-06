FROM        debian
MAINTAINER  Minh-Quan TRAN "account@itscaro.me"

# Update the package repository
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \ 
	DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl locales

# Configure timezone and locale
RUN echo "Europe/Paris" > /etc/timezone && \
	dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=en_US.UTF-8 && \
	export LANG=en_US.UTF-8 && \
	export LC_ALL=en_US.UTF-8 && \
	locale-gen en_US.UTF-8 && \
	DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

# Added dotdeb to apt
RUN echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
	echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
	echo "deb http://packages.dotdeb.org wheezy-php56 all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
	echo "deb-src http://packages.dotdeb.org wheezy-php56 all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
	wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -; apt-get update
	
# Install PHP 5
RUN apt-get install -y php5-cli php5 php5-mcrypt php5-curl php5-pgsql php5-mysql php5-gd php5-memcached php5-memcache

# Let's set the default timezone in both cli and apache configs
RUN sed -i 's/\;date\.timezone\ \=/date\.timezone\ \=\ Europe\/Paris/g' /etc/php5/*/php.ini
# Setup conf for Zend Framework
RUN sed -i 's/;include_path = ".:\/usr\/share\/php"/include_path = ".:\/var\/www\/library"/g' /etc/php5/*/php.ini

# Install Memcache
RUN apt-get install -y memcached

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Activate Apache modules
RUN a2enmod rewrite headers

# Activate Apache hosts
#ADD ./001-docker.conf /etc/apache2/sites-available/
#RUN ln -s /etc/apache2/sites-available/001-docker.conf /etc/apache2/sites-enabled/

# Set Apache environment variables (can be changed on docker run with -e)
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_SERVERADMIN admin@localhost
ENV APACHE_SERVERNAME localhost
ENV APACHE_SERVERALIAS docker.localhost
ENV APACHE_DOCUMENTROOT /var/www

#EXPOSE 80
#ADD start.sh /start.sh
#RUN chmod 0755 /start.sh
#CMD ["bash", "start.sh"]
