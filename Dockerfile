# php 7.3.9
FROM richarvey/nginx-php-fpm:1.10.3

# Configure Default Timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "America/Los_Angeles"\n' > /usr/local/etc/php/conf.d/timezone.ini

RUN apk update && \
    apk upgrade && \
    apk add nano && \
    apk add less

COPY files/php.ini /usr/local/etc/php/php.ini
COPY files/wp /usr/local/bin/wp

##  Install Ioncube
COPY files/00-ioncube.ini /usr/local/etc/php/conf.d/00-ioncube.ini
COPY files/ioncube/ioncube_loader_lin_7.4.so /usr/local/lib/php/extensions/no-debug-non-zts-20190902/ioncube_loader_lin_7.4.so
#COPY entrypoint.sh  /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
#WORKDIR /var/www/html
CMD ["/start.sh"]


## Docker image name:                           docker-image-nginx-php-fpm-wordpress
## Docker Hub image name:                       devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3
## Build command:                               docker build -t docker-image-nginx-php-fpm-wordpress ./
## Build Command No Cache:                      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./
## Docker Image Tag command:                    docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3
## Docker Image Push command:                   docker push devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3
## Docker Image Build, Tag, Push:               docker build -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3 && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3
## Docker Image Build no cache, Tag, Push:      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3 && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:1.10.3