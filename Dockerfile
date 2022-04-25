FROM openjdk:8-jre-alpine

LABEL maintainer="jberrenberg"
LABEL version="v6.0.1"


ADD https://downloads.sourceforge.net/project/davmail/davmail/6.0.1/davmail-6.0.1-3390.zip /tmp/davmail.zip

RUN adduser davmail -D && \
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

USER davmail

CMD ["/usr/local/davmail/davmail", "/etc/davmail/davmail.properties"]
