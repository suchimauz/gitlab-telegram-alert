FROM suchimauz/bash:alpine

WORKDIR /var/data/gitlab-telegram-bot

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
