FROM ghcr.io/mhsanaei/3x-ui:v2.9.0

USER root

RUN apk add --no-cache sqlite curl bash

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080
CMD ["/start.sh"]
