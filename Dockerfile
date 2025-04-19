FROM alpine:latest

RUN apk add --no-cache unzip curl && \
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp rclone-*-linux-amd64/rclone /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    rm -rf rclone-current-linux-amd64.zip rclone-*-linux-amd64

RUN addgroup -S app && adduser -S app -G app
USER app

EXPOSE 10000

CMD ["sh", "-c", "rclone serve webdav b2remote:takahirodb --addr :$PORT --user youruser --pass yourpass"]
