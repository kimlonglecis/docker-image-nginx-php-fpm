# richarvey/nginx-php-fpm:1.9.1
# Docker Tag	Docker versionPHP Version	    Nginx Version	Alpine Version	Container Scripts	Notes
# 0683e9e2      1.9.1	        8.1.12	        1.22.1	        3.16	        0.3.16	            nginx upgraded to 1.22.1 php to 8.1.12

# Docker Tag	PHP Version	    Nginx Version	Alpine Version	Container Scripts	Notes
# 1.9.1	        7.4.5	        1.16.1	        3.11	        0.3.13	            upgrade to PHP 7.4.5
FROM richarvey/nginx-php-fpm:0683e9e2

ENV CONF_D /usr/local/etc/php/conf.d
ENV IONCUBE_PATH files/ioncube
ENV IONCUBE_FILE ioncube_loader_lin_7.4.so
ENV IONCUBE_PATH_DOCKER /usr/local/lib/php/extensions/no-debug-non-zts-20190902



# Configure Default Timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "America/Los_Angeles"\n' > touch $CONF_D/timezone.ini

RUN apk update --allow-untrusted && \
    apk upgrade && \
    apk add nano && \
    apk add less

COPY files/php.ini /usr/local/etc/php/php.ini
RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

##  Install Ioncube
RUN  touch $CONF_D/00-ioncube.ini
RUN echo "zend_extension = '$IONCUBE_PATH_DOCKER/$IONCUBE_FILE'" > $CONF_D/00-ioncube.ini 
COPY $IONCUBE_PATH/$IONCUBE_FILE $IONCUBE_PATH_DOCKER/$IONCUBE_FILE
#COPY entrypoint.sh  /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
#WORKDIR /var/www/html
RUN composer self-update --2
CMD ["/start.sh"]


## Docker image name:                           docker-image-nginx-php-fpm-wordpress:1.9.1
## Docker Hub image name:                       devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1
## Build command:                               docker build -t docker-image-nginx-php-fpm-wordpress:1.9.1 ./
## Build Command No Cache:                      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress:1.9.1 ./
## Docker Image Tag command:                    docker tag docker-image-nginx-php-fpm-wordpress:1.9.1 devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1
## Docker Image Push command:                   docker push devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1
## Docker Image Build, Tag, Push:               docker build -t docker-image-nginx-php-fpm-wordpress:1.9.1 ./ && docker tag docker-image-nginx-php-fpm-wordpress:1.9.1 devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1 && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1
## Docker Image Build no cache, Tag, Push:      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress:1.9.1 ./ && docker tag docker-image-nginx-php-fpm-wordpress:1.9.1 devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1 && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:1.9.1