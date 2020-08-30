FROM nginx

COPY ./_docker/vhost.conf /etc/nginx/conf.d/default.conf
