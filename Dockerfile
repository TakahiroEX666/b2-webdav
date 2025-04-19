FROM alpine:latest

# ติดตั้ง rclone โดยตรงจาก binary release
RUN apk add --no-cache unzip curl && \
    curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cp rclone-*-linux-amd64/rclone /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone && \
    rm -rf rclone-current-linux-amd64.zip rclone-*-linux-amd64

# เพิ่ม user และเตรียม config
RUN addgroup -S app && adduser -S app -G app
USER app

COPY rclone.conf /home/app/.config/rclone/rclone.conf

EXPOSE 8080

CMD ["rclone", "serve", "webdav", "b2remote:takahirodb", "--addr", ":8080", "--user", "youruser", "--pass", "yourpass"]
