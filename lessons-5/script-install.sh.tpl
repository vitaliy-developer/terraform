#!/bin/bash
yum -y update
yum -y install httpd

myip=`curl http://169.254.169.254/latest/meta-data/local-ipv4`

cat <<EOF > /var/www/html/index.html
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>test title</title>
  </head>
  <body>
    <h2>Build Power of Terraform</h2> <br>
     Owner ${f_name} ${l_name} <br>

     %{for x in names ~}
     Hello to ${x} from ${f_name}<br>
     %{endfor ~}
  </body>
</html>
EOF
sudo service httpd start
chkconfig httpd on
