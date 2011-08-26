class rvm::passenger::apache(
  $ruby_version,
  $version,
  $rvm_prefix = '/usr/local/',
  $mininstances = '1',
  $maxpoolsize = '6',
  $poolidletime = '300',
  $maxinstancesperapp = '0',
  $spawnmethod = 'smart-lv2'
) {
  
  case $operatingsystem {
    Ubuntu: { include rvm::passenger::apache::ubuntu::pre }
    CentOS,RedHat: { include rvm::passenger::apache::centos::pre }
  }
    
  class { 'rvm::passenger::gem':
    version      => $version,
    ruby_version => $ruby_version,
  }
    
  # TODO: How can we get the gempath automatically using the ruby version
  # Can we read the output of a command into a variable?
  # e.g. $gempath = `usr/local/rvm/bin/rvm ${ruby_version} exec rvm gemdir`
  $gempath = "${rvm_prefix}rvm/gems/${ruby_version}/gems"
  $binpath = "${rvm_prefix}rvm/bin/"

  case $operatingsystem {
    Ubuntu: { include rvm::passenger::apache::ubuntu::post }
    CentOS,RedHat: { include rvm::passenger::apache::centos::post }
  }
}
