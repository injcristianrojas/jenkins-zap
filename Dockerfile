FROM jenkins/jenkins:2.277.3-lts-alpine

USER root

RUN apk --update add --no-cache maven=3.6.3-r0 binutils=2.34-r2 \
&& wget -q https://github.com/zaproxy/zaproxy/releases/download/v2.10.0/ZAP_2.10.0_Linux.tar.gz \
&& tar -xzvf ZAP_2.10.0_Linux.tar.gz -C /opt/ \
&& mv /opt/ZAP_2.10.0 /opt/zaproxy

COPY jenkins-plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt --verbose

USER jenkins