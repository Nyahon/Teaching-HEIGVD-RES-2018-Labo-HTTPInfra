<?php
	$STATIC_APP1 = getenv('STATIC_APP1');
        $STATIC_APP2 = getenv('STATIC_APP2');

	$DYNAMIC_APP1 = getenv('DYNAMIC_APP1');
        $DYNAMIC_APP2 = getenv('DYNAMIC_APP2');

?>
<VirtualHost *:80>
        ServerName demo.res.ch

        <Location "/balancer-manager">
                SetHandler balancer-manager
                Order Deny,Allow
                Deny from all
                Allow from all
        </Location>
        ProxyPass /balancer-manager !


	<Proxy balancer://myclusterrandom>
    		BalancerMember 'http://<?php print "$DYNAMIC_APP1"?>'
    		BalancerMember 'http://<?php print "$DYNAMIC_APP2"?>'
	</Proxy>
	
        ProxyPass '/api/random/' 'balancer://myclusterrandom/'
        ProxyPassReverse '/api/random/' 'balancer://myclusterrandom/'

	<Proxy balancer://mycluster>
                BalancerMember 'http://<?php print "$STATIC_APP1"?>'
                BalancerMember 'http://<?php print "$STATIC_APP2"?>'
        </Proxy>

        ProxyPass '/' 'balancer://mycluster/'
        ProxyPassReverse '/' 'balancer://mycluster/'

</VirtualHost>
