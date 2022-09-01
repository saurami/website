resource "local_file" "landing_page" {
  filename = "${path.module}/index.html"
  file_permission = "0644"

  content = <<-EOT
<html>
  <head>
    <title>Welcome to saurabh.cc</title>
  </head>
  <body>
    <h1>Welcome to my personal website !!</h1>
  </body>
</html>
EOT

}


resource "local_file" "virtual_host" {
  filename = "${path.module}/saurabh.cc.conf"
  file_permission = "0400"

  content = <<-EOT
<VirtualHost *:80>
  ServerName saurabh.cc
  ServerAlias www.saurabh.cc
  ServerAdmin saurabhm@proton.me
  DocumentRoot /var/www/saurabh.cc/public_html
  ErrorLog /var/www/saurabh.cc/log/error.log
  CustomLog /var/www/saurabh.cc/log/access.log combined
</VirtualHost>
EOT

}
