FROM nginx
MAINTAINER Michael Arndt <michael.arndt@exconcept.com>

ADD generate-ssl.sh /generate-ssl.sh
ADD proxy_forward.conf /etc/nginx/conf.d/proxy_forward.conf

RUN apt update \
 && apt install -y openssl apt-utils

RUN chmod +x /generate-ssl.sh \
 && /generate-ssl.sh
