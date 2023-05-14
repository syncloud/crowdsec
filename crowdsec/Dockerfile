ARG VERSION
FROM crowdsecurity/crowdsec:v$VERSION
RUN ln -s /staging/etc/crowdsec /etc/crowdsec
RUN cscli hub update
RUN cscli hub upgrade
RUN cscli collections install crowdsecurity/linux
RUN cscli collections install crowdsecurity/dovecot
RUN cscli collections install crowdsecurity/postfix
RUN cscli collections install crowdsecurity/nginx
