#!/bin/bash

##useful, uncomment if you're new to this game
#sudo usermod -aG docker ${USER}

#set name for our docker container. Could be taken from user, not done yet.
staticName="static_res"
dynamicName="dynamic_res"
revProxyName="revproxy_res"

staticHostname="static_host_"
dynamicHostname="dynamic_host_"
revProxyHostname="reverseprox"

staticID=0
dynamicID=0

#-------------------Functions declarations---------------------------
init() {
        ##laterholder
	cd . 
}

create_net(){
        #remove previously created subnet
        docker network rm priv_net 2>/dev/null
        #(re)create it
        docker network create --subnet=172.19.0.0/16 priv_net

}

build() {
init

echo "name: "; echo $1;
#build docker image with files in directory 'docker' 
docker build -t $1 $2

echo "built docker."

}

run_revProxy(){
    staticEnv=""
    dynamicEnv=""

    #stop previous image running with name $staticName
    docker stop $(docker ps | grep $revProxyName | cut -f1 -d ' ')
    #remove previous builded images with name $staticName
    docker rm   $(docker ps | grep $revProxyName | cut -f1 -d ' ')

    for i in `seq 1 $staticID`
    do
        staticEnv="${staticEnv} -e STATIC_APP$i=172.19.1.$i:80" 
    done
    
    for i in `seq 1 $dynamicID`
    do
        dynamicEnv="${dynamicEnv} -e DYNAMIC_APP$i=172.19.2.$i:3000" 
    done

    docker run --net priv_net -e TZ=Europe/Zurich $staticEnv $dynamicEnv -d -h $revProxyHostname  --ip 172.19.0.42 -p 8080:80 $revProxyName
}

run(){
id=0
name=""
staORdyn=0

    if [[ $1 == $staticName ]]
    then
        staticID=$2
        name=$staticHostnamei
        staORdyn=1
    elif [[ $1 == $dynamicName ]]
    then 
        dynamicID=$2
        name=$dynamicHostname
        staORdyn=2
    else 
        echo "bad call to run."
    fi
#stop previous image running with name $staticName
docker stop $(docker ps | grep $1 | cut -f1 -d ' ')
#remove previous builded images with name $staticName
docker rm   $(docker ps | grep $1 | cut -f1 -d ' ')

for i in `seq 1 $2`
do
     # -e    : set environment variables
     # TZ    : define timezone
     # -d    : run as deamon
     # --net : connect network to previously created subnet
     # -p    : map container port 80 to machine port 9090
     # --ip  : set a fixed ip
     docker run -e TZ=Europe/Zurich --net priv_net -h ${name}$i --ip 172.19.${staORdyn}.$i -d $1
 done

}

run_in_bash(){
	docker run -e TZ=Europe/Zurich -it $imgname /bin/bash
}

run_portainer(){

    #stop previous image running with name $staticName
    docker stop $(docker ps | grep portainer | cut -f1 -d ' ')
    
    docker volume create portainer_data
    docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
    firefox-trunk "localhost:9000"
}

#-----------------------Usability------------------------------------
authors() { echo "=====authors=======";
            echo "Yohann    Meyer";
            echo "Johanna   Melly";
            }

usage() { echo "Usage: $0 [-b] [-r N] [-p] [-u] [-h]" 1>&2; exit 1; }

helpf() { echo "Docker builder for first part of HTTP lab, RES course : ";
           echo "     -a : authors of this lab";
           echo "     -r : run N instances of static and N of dynamic docker";
           echo "     -b : build dockers";
           echo "     -p : run portainer and go to page";
       }

#--------------------------Main Loop---------------------------------

while getopts ":ar:bhpt" o; do
    echo ${o};
    case "${o}" in
        a)
            authors
	    ;;
        r)  n=${OPTARG}
	        run $staticName $n
            run $dynamicName $n
            run_revProxy 
            ;;
        b)
            #staticName=${OPTARG}
	        create_net
            build $revProxyName test-reverse-proxy
            build $staticName docker
            build $dynamicName express-image
            ;;
        h)
            helpf
            ;;
        t)
            run_in_bash
            ;;
        p)
            run_portainer
            ;;
        *)
            usage
            ;;
    esac
done

