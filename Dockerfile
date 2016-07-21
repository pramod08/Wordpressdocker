FROM ubuntu:14.04

MAINTAINER Bizruntime@pramod


# Install plugins
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y wget curl python  && \
apt-get install -y nano php5 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-intl php-pear && \
apt-get -y install php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite && \
apt-get install -y php5-tidy php5-xmlrpc php5-xsl && \
apt-get install -y git  && apt-get install -y supervisor

ADD apachesupervisor.conf /etc/supervisor/conf.d/apachesupervisor.conf

# Download Wordpress from git into /opt
RUN  git clone  https://github.com/pramod08/Wordpress.git  /opt

# Configure Wordpress to connect to local DB
ADD wp-config.php /opt/wp-config.php
# Configure the apache PHP
ADD dir.conf  /etc/apache2/mods-enabled/dir.conf

# Modify permissions to allow plugin upload
RUN cp -R /opt/* /var/www/html/
RUN chown -R www-data:www-data  /var/www/html

ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 80 3306
CMD ["/run.sh"]
