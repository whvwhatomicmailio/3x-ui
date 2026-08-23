FROM ghcr.io/mhsanaei/3x-ui:v2.9.4
USER root
RUN apk add --no-cache sqlite bash curl
COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 8080
CMD ["/start.sh"]
