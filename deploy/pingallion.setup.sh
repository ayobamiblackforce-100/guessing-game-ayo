#!/usr/bin/bash

apt install nginx -y
DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io
# apt install docker.io -y
# apt install docker-compose -y

subdomain="games.pingallion.com"
image="ayobamiblackforce/guessing-game-prod"

docker rm -f $(docker ps -aq)
docker run -d --name $subdomain -p 127.0.0.1:8501:8501 $image

cp $subdomain /etc/nginx/sites-available/$subdomain
ln -s /etc/nginx/sites-available/$subdomain /etc/nginx/sites-enabled/$subdomain
rm /etc/nginx/sites-enabled/default
nginx -t && nginx -s reload


#manage SSL certificates with certbot
sudo snap install --classic certbot
sudo certbot --nginx --non-interactive --agree-tos --domain $subdomain 
nginx -t && nginx -s reload
