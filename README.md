# Private docker registry and web interface

## Installation
There are two options. The first one is to install app via Makefile
and the second one is to install via debian package (recommended for debian-based systems).

### From sources
Clone this repository and execute `sudo make install`. Then execute
```bash
sudo make install
sudo systemctl daemon-reload
sudo systemctl start docker-registry

# enable autostart
sudo systemctl enable docker-registry
```

### From deb package
Clone repo or download `build/docker-registry.deb` file.
```bash
sudo dpkg -i docker-registry.deb
```
The script will autoenable and autostart the registry.

## Run with docker
```bash
docker-compose up
```

## Install as a systemd service
```bash
# install
sudo make install

# start
sudo systemctl start docker-registry

# enable autostart on boot
sudo systemctl enable docker-registry
```

Once installed, navigate `localhost:5080`.

## SSL and security
Read about how to add SSL at [docker-registry-frontend](https://hub.docker.com/r/konradkleine/docker-registry-frontend/) and [library/registry](https://hub.docker.com/_/registry/).
Those topics are also cover protection with auth.

## Futher steps
Add a new virtual host to your server and setup it to proxy requests to the `docker-registry`
to make registry be open to public.

### Example:
```lua
# /etc/nginx/sites-enabled/registry.conf
server {
    listen       80;
    server_name  registry.mydomain.com;

    location / {
        proxy_pass http://localhost:5080;
    }
}
```

#### Usage
```bash
# pull image
docker pull registry.mydomain.com/myimagename

# push image
docker tag somecontainer registry.mydomain.com/myimagename
docker push registry.mydomain.com/myimagename
```
