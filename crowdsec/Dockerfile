ARG VERSION
FROM crowdsecurity/crowdsec:v$VERSION
RUN cscli hub update
RUN cscli hub collections install crowdsecurity/dovecotts/*
