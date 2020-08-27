# GOOD dockerfile
#FROM alpine:latest
#EXPOSE 9999
#RUN apk add wget
#USER 65534:65534
#CMD /bin/sh

# BAD dockerfile
FROM alpine:latest
EXPOSE 22
RUN apk add curl
CMD /bin/sh
