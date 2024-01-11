FROM eclipse-temurin:19-jre-alpine

LABEL maintainer="jberrenberg"
LABEL version="v6.1.0"


ADD https://downloads.sourceforge.net/project/davmail/davmail/6.1.0/davmail-6.1.0-3423.zip /tmp/davmail.zip

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN adduser davmail -D && \
  apk add --no-cache su-exec openssl && \
  mkdir /usr/local/davmail && \
  unzip -q /tmp/davmail.zip -d /usr/local/davmail && \
  rm /tmp/davmail.zip

VOLUME        /etc/davmail
VOLUME        /var/log/davmail

EXPOSE        1080
EXPOSE        1143
EXPOSE        1389
EXPOSE        1110
EXPOSE        1025
WORKDIR       /usr/local/davmail

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/local/davmail/davmail", "/etc/davmail/davmail.properties"]
