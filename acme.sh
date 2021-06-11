#安装nginx	http://nginx.org/en/linux_packages.html
#debian
sudo apt install curl gnupg2 ca-certificates lsb-release
echo "deb http://nginx.org/packages/mainline/debian `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
curl -o /tmp/nginx_signing.key https://nginx.org/keys/nginx_signing.key
sudo mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc
sudo apt update
sudo apt install nginx

#acme.sh 切换默认ca到zerossl
curl https://get.acme.sh | sh 
#或者	wget -O -  https://get.acme.sh | sh

acme.sh  --register-account  --server zerossl --eab-kid xxxxx --eab-hmac-key  xxxxx
acme.sh --set-default-ca  --server zerossl
acme.sh  --issue  -d yourdomain.com --webroot /usr/share/nginx/html/ --keylength ec-256
acme.sh --install-cert -d example.com --ecc \
    --key-file       /usr/local/etc/xray/ssl/key.pem  \
    --fullchain-file /usr/local/etc/xray/ssl/cert.pem \
    --reloadcmd     "systemctl restart xray"

#使用buypass 证书
acme.sh --server https://api.buypass.com/acme/directory \
        --register-account  --accountemail your@example.com
acme.sh --set-default-ca  --server buypass
acme.sh --server https://api.buypass.com/acme/directory \
         --issue -d example.com --webroot /usr/share/nginx/html/ \
         --keylength ec-256  --days 170
acme.sh --install-cert -d example.com --ecc \
    --key-file       /usr/local/etc/xray/ssl/key.pem  \
    --fullchain-file /usr/local/etc/xray/ssl/cert.pem \
    --reloadcmd     "systemctl restart xray"