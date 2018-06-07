#Source: https://hub.docker.com/_/php/
FROM php:7.0-apache
COPY content/ /var/www/html/
RUN apt-get update
#RUN apt-get install vim
#RUN Y
COPY src/001-proxy-reverse.conf /etc/apache2/sites-available/001-proxy-reverse.conf
RUN service apache2 restart
RUN a2enmod proxy proxy_http
RUN service apache2 restart
#RUN service apache2 reload
RUN a2ensite 001*
RUN service apache2 restart
