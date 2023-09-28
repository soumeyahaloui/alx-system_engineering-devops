# Puppet Manifest to Kill a Process Named "killmenow"

exec { 'kill_killmenow':
  command => 'pkill -f "killmenow"',
  onlyif  => 'pgrep -f "killmenow"',
}
