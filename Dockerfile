FROM alpine:latest

RUN apk add --no-cache curl && \
    curl https://rclone.org/install.sh | sh

RUN addgroup -S app && adduser -S app -G app
USER app

COPY rclone.conf /home/app/.config/rclone/rclone.conf

EXPOSE 8080

CMD ["rclone", "serve", "webdav", "b2remote:takahirodb", "--addr", ":8080", "--user", "youruser", "--pass", "yourpass"]
