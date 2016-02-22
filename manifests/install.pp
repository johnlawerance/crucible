class crucible::install inherits crucible {

  # Install Java
  class { 'java':
    distribution => 'jre',
    package  => 'java-1.8.0-openjdk',
  }

  # Setup service user
  user { "$service_user":
    ensure => present,
    home   => '/home/crucible',
    shell  => '/sbin/nologin',
  }

  # exec to download and install the crucible directory if version file doesn't exist
  exec { 'install_crucible':
    command => "/usr/bin/wget -q -O /tmp/crucible-$version.zip https://www.atlassian.com/software/crucible/downloads/binary/crucible-$version.zip && /usr/bin/unzip /tmp/crucible-$version.zip -d /tmp/ && mv /tmp/fecru-$version $install_dir-$version && chown -R $service_user.$service_user $install_dir-$version",
    creates => "/opt/crucible-$version",
    require => User[$service_user],
  }

  # symlink versioned directory with /opt/crucible/ directory name
  file { 'crucible_dir':
    path    => "$install_dir",
    ensure  => 'link',
    owner   => "$service_user",
    target  => "$install_dir-$version"
    require => User[$service_user],
  }

}
