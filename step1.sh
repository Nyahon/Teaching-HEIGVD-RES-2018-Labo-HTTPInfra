#!/bin/bash

##useful, uncomment if you're new to this game
#sudo usermod -aG docker ${USER}

imgName="aphpache"


init() {
        ##laterholder
	cd . 
}

create_net(){

        docker network create --subnet=172.19.0.0/16 priv_net

}
build_server() {
init
echo "name: ";
echo $imgName;
#build docker image
docker build -t $imgName docker

#stop previous image running
docker stop $(docker ps | grep $imgName | cut -f1 -d ' ')
docker rm   $(docker ps | grep $imgName | cut -f1 -d ' ')

#run image

}

run_server(){
	
	# docker run -e TZ=Europe/Zurich -d --net priv_net -p 9090:80 --ip 172.18.0.41 $imgName
	docker run -e TZ=Europe/Zurich -d -p 9090:80 $imgName
}

authors() { echo "=====authors=======";
            echo "Yohann    Meyer";
            echo "Johanna   Melly";
            }

usage() { echo "Usage: $0 [-r] [-b] [-u] [-h]" 1>&2; exit 1; }

helpf() { echo "Docker builder for first part of HTTP lab, RES course : ";
           echo "     -a : authors of this lab";
           echo "     -r : run docker";
           echo "     -b : build server docker";
       }


while getopts ":arbh" o; do
    echo ${o};
    case "${o}" in
        a)
            authors
	    ;;
        r)
	    run_server
            ;;
        d)
            ;;
        b)
            #imgName=${OPTARG}
	    create_net
            build_server
            ;;
        h)
            helpf
            ;;
        *)
            usage
            ;;
    esac
done

