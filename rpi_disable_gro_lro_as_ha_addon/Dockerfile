FROM alpine:3.19

RUN apk add --no-cache ethtool iproute2

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD [ "/run.sh" ]