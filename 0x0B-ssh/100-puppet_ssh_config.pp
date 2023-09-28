# Puppet manifest to configure SSH client settings

# Ensure the SSH directory exists
file { '/home/your_username/.ssh':
  ensure => 'directory',
  owner  => 'your_username',
  group  => 'your_username',
  mode   => '0700',
}

# Create the private key file if it doesn't exist
file { '/home/your_username/.ssh/school':
  ensure => 'file',
  owner  => 'your_username',
  group  => 'your_username',
  mode   => '0600',
  content => 'YourPrivateKeyContentsHere',
}

# Configure SSH client to use the private key
file_line { 'Configure SSH to use private key':
  path    => '/home/your_username/.ssh/config',
  line    => 'IdentityFile ~/.ssh/school',
  match   => '^#?IdentityFile.*',
  ensure  => present,
  require => File['/home/your_username/.ssh'],
}

# Ensure SSH client refuses password authentication
file_line { 'Disable password authentication':
  path    => '/home/your_username/.ssh/config',
  line    => 'PasswordAuthentication no',
  match   => '^#?PasswordAuthentication.*',
  ensure  => present,
  require => File['/home/your_username/.ssh'],
}

# Make sure there's a newline at the end of the SSH config file
exec { 'Add newline to SSH config':
  command     => 'echo >> /home/your_username/.ssh/config',
  refreshonly => true,
  subscribe   => File_line['Configure SSH to use private key', 'Disable password authentication'],
}
