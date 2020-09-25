FROM alpine:latest


# GOOD dockerfile
EXPOSE 9999
RUN apk add wget
USER 65534:65534

# BAD dockerfile
#EXPOSE 22
#RUN apk add curl


CMD /bin/sh
