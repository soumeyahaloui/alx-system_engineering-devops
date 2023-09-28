# kill process killmenow

exec { 'pkill':
  command  => 'pkill killmenow',
  provider => 'shell',
}
root@40fae6251cd2:/alx-system_engineering-devops/0x0A-configuration_management# cd ..
root@40fae6251cd2:/alx-system_engineering-devops# cd 0x0B-ssh
root@40fae6251cd2:/alx-system_engineering-devops/0x0B-ssh# cat 1-create_ssh_key_pair
#!/usr/bin/env bash
# Bash script that creates an RSA key pair
#ssh-keygen -b 4096 -P betty -f school
ssh-keygen -t rsa -b 4096 -P betty -f school
root@40fae6251cd2:/alx-system_engineering-devops/0x0B-ssh# cat 100-puppet_ssh_config.pp
# Puppet script to create ssh config file
file_line { 'Turn off passwd auth':
  ensure => 'present',
  path   => '/etc/ssh/ssh_config',
  line   => '    PasswordAuthentication no',
}

file_line { 'Declare identity file':
  ensure => 'present',
  path   => '/etc/ssh/ssh_config',
  line   => '    IdentityFile ~/.ssh/school',
}
