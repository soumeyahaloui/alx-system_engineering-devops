# Ensure Nginx is installed
package { 'nginx':
  ensure => installed,
}

# Define a custom Nginx configuration file
file { '/etc/nginx/sites-available/custom-header':
  ensure  => present,
  content => "server {\n  listen 80;\n  server_name _;\n  add_header X-Served-By $hostname;\n  location / {\n    proxy_pass http://localhost;\n    proxy_http_version 1.1;\n    proxy_set_header Upgrade \$http_upgrade;\n    proxy_set_header Connection 'upgrade';\n    proxy_set_header Host \$host;\n    proxy_cache_bypass \$http_upgrade;\n  }\n}\n",
}

# Create a symbolic link to enable the custom configuration
file { '/etc/nginx/sites-enabled/custom-header':
  ensure => link,
  target => '/etc/nginx/sites-available/custom-header',
  notify => Service['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-enabled/custom-header'],
}
