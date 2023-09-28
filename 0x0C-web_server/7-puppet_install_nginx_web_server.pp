# 7-puppet_install_nginx_web_server.pp

# Install Nginx package
package { 'nginx':
  ensure => 'installed',
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  ensure => file,
  source => 'puppet:///modules/nginx/default',
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => 'running',
  enable => true,
}

# Create a simple "Hello World!" HTML page
file { '/var/www/html/index.html':
  ensure  => file,
  content => '<!DOCTYPE html>
<html>
<head>
    <title>Hello World!</title>
</head>
<body>
    <h1>Hello World!</h1>
</body>
</html>',
}

# Create a 301 redirect configuration
file { '/etc/nginx/sites-available/redirect_me':
  ensure  => file,
  content => 'server {
    listen 80;
    server_name _;
    return 301 http://$host$request_uri;
}',
}

# Enable the redirect site
file { '/etc/nginx/sites-enabled/redirect_me':
  ensure  => link,
  target  => '/etc/nginx/sites-available/redirect_me',
  require => File['/etc/nginx/sites-available/redirect_me'],
}

# Ensure Nginx service is restarted when the configuration changes
Service['nginx'] ~> File['/etc/nginx/sites-available/default']
Service['nginx'] ~> File['/etc/nginx/sites-available/redirect_me']
