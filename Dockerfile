FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
LABEL maintainer="호성"
HEALTHCHECK --interval=30s CMD wget -q -O /dev/null http://localhost/ || exit 1