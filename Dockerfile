
# Docker Tag	PHP Version	Nginx Version	Alpine Version	Container Scripts	Notes
# 3.1.6	        8.2.7	    1.24-r6	        3.18	        0.3.17	            upgrade to php 8.2.5
# 3.1.5	        8.2.6	    1.24-r6	        3.18	        0.3.17	            upgrade to php 8.2.6
# 3.1.4	        8.2.5	    1.22.1	        3.17	        0.3.17	            upgrade to php 8.2.5
# 3.1.3	        8.2.4	    1.22.1	        3.17	        0.3.17	            adding mongoDB support #281
# 3.1.2	        8.2.4	    1.22.1	        3.17	        0.3.17	            fix #280
# 3.1.1	        8.2.4	    1.22.1	        3.17	        0.3.17	            upgrade to php 8.2.4
# 3.1.0	        8.2.3	    1.22.1	        3.17	        0.3.17	            reduced image size
# 3.0.2	        8.2.3	    1.22.1	        3.17	        0.3.17	            fixed gd2 and xsl errors
# 3.0.1	        8.2.3	    1.22.1	        3.17	        0.3.17	            no cache typo fixed + TZ fixed in scripts
# 3.0.0	        8.2.3	    1.22.1	        3.17	        0.3.16	            upgraded php to 8.2.3 switched to packaged nginx
# 0683e9e2      1.9.1	        8.1.12	        1.22.1	        3.16	        0.3.16	            nginx upgraded to 1.22.1 php to 8.1.12
# 1.9.1	        7.4.5	        1.16.1	        3.11	        0.3.13	            upgrade to PHP 7.4.5


FROM richarvey/nginx-php-fpm:3.1.6

## Ioncube ENV
# ENV CONF_D /usr/local/etc/php/conf.d
# ENV IONCUBE_PATH files/ioncube
# ENV IONCUBE_FILE ioncube_loader_lin_7.4.so
# ENV IONCUBE_PATH_DOCKER /usr/local/lib/php/extensions/no-debug-non-zts-20190902



# Configure Default Timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "America/Los_Angeles"\n' > touch $CONF_D/timezone.ini

RUN apk update && \
    apk upgrade && \
    apk add nano && \
    apk add less

COPY files/php.ini /usr/local/etc/php/php.ini
COPY files/wp /usr/local/bin/wp

##  Install Ioncube
# RUN  touch $CONF_D/00-ioncube.ini
# RUN echo "zend_extension = '$IONCUBE_PATH_DOCKER/$IONCUBE_FILE'" > $CONF_D/00-ioncube.ini 
# COPY $IONCUBE_PATH/$IONCUBE_FILE $IONCUBE_PATH_DOCKER/$IONCUBE_FILE
#COPY entrypoint.sh  /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT [ "/entrypoint.sh" ]
##  5. Set WOKR_DIR
#WORKDIR /var/www/html
CMD ["/start.sh"]


## Docker image name:                           docker-image-nginx-php-fpm-wordpress
## Docker Hub image name:                       devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6
## Build command:                               docker build -t docker-image-nginx-php-fpm-wordpress ./
## Build Command No Cache:                      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./
## Docker Image Tag command:                    docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6
## Docker Image Push command:                   docker push devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6
## Docker Image Build, Tag, Push:               docker build -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6 && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6
## Docker Image Build no cache, Tag, Push:      docker build --no-cache -t docker-image-nginx-php-fpm-wordpress ./ && docker tag docker-image-nginx-php-fpm-wordpress devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6 && docker push devtutspace/docker-image-nginx-php-fpm-wordpress:3.1.6