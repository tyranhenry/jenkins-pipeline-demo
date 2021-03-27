FROM alpine:latest
#FROM debian:stable

# GOOD dockerfile
#EXPOSE 9999
#RUN apk add wget
#USER 65534:65534
#HEALTHCHECK CMD /bin/true

# BAD dockerfile
EXPOSE 22
RUN apk add curl
RUN echo "aws_access_key_id=01234567890123456789" > /aws_key && \
    echo "aws_secret_access_key=0123456789012345678901234567890123456789" > /aws_secret_key && \
    echo "--BEGIN PRIVATE KEY--" > /private_key && \
    echo "auth: \\"something\\"" > /docker_auth && \
    echo "api-key=00000000000000000000000" > /api_key

CMD /bin/sh
