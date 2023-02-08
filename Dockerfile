# richarvey/nginx-php-fpm:2.2.0
# Docker Tag	PHP Version	    Nginx Version	Alpine Version	Container Scripts	Notes
# 2.2.0	        8.1.12	        1.22.1	        3.16	        0.3.16	            nginx upgraded to 1.22.1 php to 8.1.12
FROM richarvey/nginx-php-fpm:0683e9e2

ENV CONF_D /usr/local/etc/php/conf.d
ENV IONCUBE_PATH files/ioncube
ENV IONCUBE_FILE ioncube_loader_lin_7.4.so
ENV IONCUBE_PATH_DOCKER /usr/local/lib/php/extensions/no-debug-non-zts-20190902



# Configure Default Timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "America/Los_Angeles"\n' > touch $CONF_D/timezone.ini

RUN apk update && \
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


## Docker image name:                           docker-image-nginx-php-fpm-wordpress
## Docker Hub image name:                       devtutspace/docker-image-nginx-php-fpm-wordpress:latest
## Build command:                               docker build -t docker-image-nginx-php-fpm-wordpress ./
## Build Command No Cache:                      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./
## Docker Image Tag command:                    docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:latest
## Docker Image Push command:                   docker push devtutspace/docker-image-nginx-php-fpm-wordpress:latest
## Docker Image Build, Tag, Push:               docker build -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:latest && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:latest
## Docker Image Build no cache, Tag, Push:      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:latest && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:latest