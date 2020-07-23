FROM alpine:latest
EXPOSE 22
RUN apk add curl
CMD /bin/sh
