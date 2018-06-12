#Source: https://hub.docker.com/_/php/
FROM php:7.0-apache
#COPY content/ /var/www/html/
RUN apt-get update && \
	apt-get install -y vim
#RUN apt-get install vim
#RUN Y
COPY apache2-foreground /usr/local/bin/
COPY templates /var/apache2/templates

COPY src/* /etc/apache2/sites-available/
#RUN service apache2 restart
RUN a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests
#ssl proxy_fcgi slotmem_shm proxy_ftp proxy_ajp proxy_wstunnel lbmethod_bytraffic lbmethod_bybusyness lbmethod_heartbeat status
#RUN service apache2 restart
#RUN service apache2 reload
RUN a2ensite 001* 000*
#RUN service apache2 restart
