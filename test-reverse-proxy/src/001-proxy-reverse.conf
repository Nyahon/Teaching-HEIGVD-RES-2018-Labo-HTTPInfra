<VirtualHost *:80> 
        ServerName demo.res.ch 
         
        ProxyPass "/api/random/" "http://172.17.0.2:3000/" 
        ProxyPassReverse "/api/random/" "http://172.17.0.2:3000/" 
 
        ProxyPass "/" "http://172.19.0.41:80/" 
        ProxyPassReverse "/" "http://172.19.0.41:80/" 
 
        ErrorLog ${APACHE_LOG_DIR}/error.log 
        CustomLog ${APACHE_LOG_DIR}/access.log combined 
 
</VirtualHost> 
 
# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

