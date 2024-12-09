FROM nginx:alpine

COPY ./vue/dist /opt/app/dist

COPY ./infra/production/nginx/default.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html

EXPOSE 80
