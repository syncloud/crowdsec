ARG VERSION
FROM crowdsecurity/crowdsec:v$VERSION
RUN ln -s /staging/etc/crowdsec /etc/crowdsec
RUN cscli hub update
RUN cscli hub collections install crowdsecurity/dovecot
