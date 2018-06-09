FROM alpine:3.7

COPY goose/bin/goose-linux64 /usr/local/bin/goose
RUN chmod +x /usr/local/bin/goose