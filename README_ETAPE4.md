#Au préalable
Éditer le fichier _hosts_ avec la commande __sudo vim /etc/hosts__  
Y ajouter la ligne __172.17.0.4   demo.res.ch__  
_Pourquoi cette adresse?_ Parce qu'il s'agit de l'IP de notre container du reverse proxy.  
_Pourquoi ce nom?_ Parce que c'est le nom de l'hôte qu'on a défini dans notre site _001-proxy-reverse.conf_.  
  
#Pour lancer le tout (__À FAIRE IMPÉRATIVEMENT DANS L'ORDRE__)
1. Builder les images des dossiers test-reverse-proxy et express-image, dans ce README nous appellerons ces images respectivement res/rp et res/random
2. Lancer le container de express-image avec _docker run -d -p 9091:3000 res/random_
3. Lancer le script avec _\step1.sh -b -r_
4. Lancer le container du reverse proxy avec _docker run -d -p 8080:80 res/rp_
Il est important de le faire dans cet ordre afin que les adresses IP de chaque container corresponde à celle qu'on attend.  

#Visualiser le résultat
1. Ouvrir un brower et, dans l'URL, taper _demo.res.ch_
2. Le site avec un contenu dynamiquement chargé devrait se présenter
3. Taper maintenant _demo.res.ch/api/random/_ (attention à ne pas omettre de backslash)
4. Du contenu JSON devrait se présenter
