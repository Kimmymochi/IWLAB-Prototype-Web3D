FROM nginx:latest
COPY --chown=1001:1001 /html /usr/share/nginx/html
COPY --chown=1001:1001 nginx.conf /etc/nginx/nginx.conf
RUN chmod g+rwx /var/cache/nginx /var/run /var/log/nginx && chmod -R g+w /etc/nginx
EXPOSE 8080