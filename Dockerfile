FROM richarvey/nginx-php-fpm:latest


RUN apk update && \
    apk upgrade && \
    apk add nano && \
    apk add less

COPY files/php.ini /usr/local/etc/php/php.ini
COPY files/wp /usr/local/bin/wp
#COPY entrypoint.sh  /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
#WORKDIR /var/www/html
CMD ["/start.sh"]


## Docker image name:                           docker-image-nginx-php-fpm-wordpress
## Docker Hub image name:                       devtutspace/docker-image-nginx-php-fpm-wordpress
## Build command:                               docker build -t docker-image-nginx-php-fpm-wordpress ./
## Build Command No Cache:                      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./
## Docker Image Tag command:                    docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress
## Docker Image Push command:                   docker push devtutspace/docker-image-nginx-php-fpm-wordpress
## Docker Image Build, Tag, Push:               docker build -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress && docker push devtutspace/docker-image-nginx-php-fpm-wordpress
## Docker Image Build no cache, Tag, Push:      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress && docker push devtutspace/docker-image-nginx-php-fpm-wordpress