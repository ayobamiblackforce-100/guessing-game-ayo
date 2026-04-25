server {
    listen 80;
    listen [::]:80;
    server_name games.pingallion.com;

    # Optional: Log files for troubleshooting
    access_log /var/log/nginx/games.pingallion.com.access.log;
    error_log /var/log/nginx/games.pingallion.com.error.log;

    location / {
        # Forward traffic to the local Docker container port
        proxy_pass http://127.0.0.1:8501;

        # Standard headers to pass client information to the container
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # WebSocket support (important for many modern web games/apps)
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
