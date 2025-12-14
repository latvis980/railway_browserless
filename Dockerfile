FROM caddy:latest AS caddy
COPY Caddyfile ./
RUN caddy fmt --overwrite Caddyfile

FROM ghcr.io/browserless/chromium:latest

ENV ENABLE_DEBUGGER=false
ENV DEBUG=browserless:server
ENV PRINT_NETWORK_INFO=false

COPY --from=caddy /srv/Caddyfile ./
COPY --from=caddy /usr/bin/caddy /usr/bin/caddy
COPY --chmod=755 scripts/* ./

ENTRYPOINT ["/bin/sh"]
CMD ["start.sh"]
