#Pour tester le bon fonctionnement avec des adresses random
1. Builder les images, ici on dira que celle d'express s'appelle res/random, celle de docker (pour le site static) (ici on n'utilisera pas le script) s'appelle toujours aphpache et celle du proxy res/rp
2. Lancer plusieurs containers avec _docker run -d aphpache_
3. En lancer un supplémentaire avec _docker run --name static -d aphpache_
4. Lancer plusieurs containers avec _docker run -d res/random_
5. En lancer un supplémentaire avec _docker run --name dynamic -d res/random_
6. Récupérer leurs adresses IP avec _docker inspect static | grep -i ipaddr_ et _docker inspect dynamic | grep -i ipaddr_
7. Lancer le reverse proxy avec *docker run -e STATIC\_APP=172.17.0.3:80 -e DYNAMIC\_APP=172.17.0.2:3000 --name reverseprox -p 8080:80 res/rp*, en ayant rempli les adresses IP avec celles trouvées plus tôt.
