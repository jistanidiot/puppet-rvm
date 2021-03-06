class rvm::system (
  $version      = $rvm::params::version,
  $trust_rvmrcs = $rvm::params::trust_rvmrcs
) inherits rvm::params {

  require rvm::dependencies

  exec { 'system-rvm':
    path    => '/usr/bin:/usr/sbin:/bin',
    command => "bash -c '/usr/bin/curl -s https://rvm.beginrescueend.com/install/rvm -o rvm-installer ; chmod +x rvm-installer ; rvm_bin_path=/usr/local/rvm/bin rvm_man_path=/usr/local/rvm/man ./rvm-installer --version ${version}'",
    creates => '/usr/local/rvm/bin/rvm',
    require => Class['rvm::dependencies'],
  }
  
  if $rvm_installed == 'true' and $trust_rvmrcs {
    common::line { 'trust-rvmrcs':
      ensure => present,
      file   => '/etc/rvmrc',
      line   => 'rvm_trust_rvmrcs_flag=1',
    }
  }
}
