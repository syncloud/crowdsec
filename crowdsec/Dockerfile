ARG VERSION
FROM crowdsecurity/crowdsec:v$VERSION
RUN ln -s /staging/etc/crowdsec /etc/crowdsec
RUN mkdir -p /var/snap/crowdsec/current/config
RUN ln -s /staging/etc/crowdsec /var/snap/crowdsec/current/config/crowdsec
RUN sed -i 's#/etc/crowdsec#/var/snap/crowdsec/current/config/crowdsec#g' /staging/etc/crowdsec/config.yaml
RUN rm -rf /staging/etc/crowdsec/parsers
RUN rm -rf /staging/etc/crowdsec/scenarios
RUN rm -rf /staging/etc/crowdsec/collections
RUN rm -rf /staging/etc/crowdsec/hub/*
RUN cscli hub update
RUN cscli hub upgrade
RUN cscli collections install crowdsecurity/linux
RUN cscli collections install crowdsecurity/dovecot
RUN cscli collections install crowdsecurity/postfix
RUN cscli collections install crowdsecurity/nginx
