# docker

install docker-compose:

 sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
 
 sudo chmod +x /usr/local/bin/docker-compose
 
 docker-compose --version
 
 #############

https://docs.docker.com/compose/gettingstarted/

#cd composetest
# docker-compose up

URL :  http://0.0.0.0:5000



to create seperate network:

create you own docker network (mynet123)

docker network create --subnet=172.18.0.0/16 mynet123

than simply run the image (I'll take ubuntu as example)

docker run --net mynet123 --ip 172.18.0.22 -it ubuntu bash

then in ubuntu shell

ip address

Additionally you could use

    --hostname to specify a hostname
    --add-host to add more entries to /etc/hosts
