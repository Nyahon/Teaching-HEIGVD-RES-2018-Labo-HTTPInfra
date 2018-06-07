#!/bin/bash

##useful, uncomment if you're new to this game
#sudo usermod -aG docker ${USER}

#set name for our docker container. Could be taken from user, not done yet.
imgName="aphpache"


#-------------------Functions declarations---------------------------
init() {
        ##laterholder
	cd . 
}

create_net(){
        #remove previously created subnet
        docker network rm priv_net 2>/dev/null
        #(re)create it
        #docker network create --subnet=172.19.0.0/16 priv_net

}
build_server() {
init
echo "name: ";
echo $imgName;
#build docker image with files in directory 'docker' 
docker build -t $imgName docker

#stop previous image running with name $imgName
docker stop $(docker ps | grep $imgName | cut -f1 -d ' ')
#remove previous builded images with name $imgName
docker rm   $(docker ps | grep $imgName | cut -f1 -d ' ')


}

run_server(){
     # -e    : set environment variables
     # TZ    : define timezone
     # -d    : run as deamon
     # --net : connect network to previously created subnet
     # -p    : map container port 80 to machine port 9090
     # --ip  : set a fixed ip
	 docker run -e TZ=Europe/Zurich -d -p 9090:80  $imgName
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

#--------------------------Main Loop---------------------------------

while getopts ":arbh" o; do
    echo ${o};
    case "${o}" in
        a)
            authors
	    ;;
        r)
	    run_server
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

