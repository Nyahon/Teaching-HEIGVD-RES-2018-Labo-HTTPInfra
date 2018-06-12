Suivre les mêmes étapes que pour la 5, mais il faut lancer au moins 2 containers statics et 2 containers dynamiques, récupérer les IP, et lancer le serveur avec:  
docker run -e STATIC\_APP1=172.17.0.2:80 -e STATIC\_APP2=171.17.0.3:80 -e DYNAMIC\_APP1=172.17.0.4:3000 -e DYNAMIC\_APP2=172.17.0.5:3000 --name reverseprox -p 8080:80 res/rp
