FROM nginx:stable@sha256:4a1d2e00b08fce95e140e272d9a0223d2d059142ca783bf43cf121d7c11c7df8
FROM nginx:stable
COPY default.conf /etc/nginx/conf.d/
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
