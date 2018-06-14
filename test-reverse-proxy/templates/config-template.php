<?php
	$STATIC_APP1 = getenv('STATIC_APP1');
        $STATIC_APP2 = getenv('STATIC_APP2');

	$DYNAMIC_APP1 = getenv('DYNAMIC_APP1');
        $DYNAMIC_APP2 = getenv('DYNAMIC_APP2');

?>
<VirtualHost *:80>
	Header add Set-Cookie "ROUTEID=.%{BALANCER_WORKER_ROUTE}e; path=/" env=BALANCER_ROUTE_CHANGED
        ServerName demo.res.ch
        <Location /balancer-manager>
                SetHandler balancer-manager
                Order Deny,Allow
                Deny from all
                Allow from all
        </Location>
        ProxyPass /balancer-manager !
	<Proxy balancer://myclusterrandom>
    		BalancerMember 'http://<?php print "$DYNAMIC_APP1"?>' route=1
    		BalancerMember 'http://<?php print "$DYNAMIC_APP2"?>' route=2
		ProxySet stickysession=ROUTEID
	</Proxy>
	
        ProxyPass '/api/random/' 'balancer://myclusterrandom/'
	ProxyPassReverse '/api/random/' 'balancer://myclusterrandom/'

	<Proxy balancer://mycluster>
                BalancerMember 'http://<?php print "$STATIC_APP1"?>' route=3
                BalancerMember 'http://<?php print "$STATIC_APP2"?>' route=4
		ProxySet stickysession=ROUTEID
        </Proxy>

        ProxyPass '/' 'balancer://mycluster/'
        ProxyPassReverse '/' 'balancer://mycluster/'

</VirtualHost>
