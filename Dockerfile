# GOOD dockerfile
FROM alpine:latest
USER 65534:65534
EXPOSE 9999
RUN apk add wget
CMD /bin/sh

# BAD dockerfile
#FROM alpine:latest
#EXPOSE 22
#RUN apk add curl
#CMD /bin/sh
