class crucible::install {

  # Install Java
  if $crucible::install_java == true {
    class { 'java':
      distribution => 'jre',
      package      => 'java-1.8.0-openjdk',
    }
  }

  # Setup service user
  user { $crucible::service_user:
    ensure => present,
    home   => "/home/${crucible::service_user}",
    shell  => '/bin/bash',
  }

  # Download and install the crucible directory if version file doesn't exist
  exec { 'install_crucible':
    command => "/usr/bin/wget -q -O /tmp/crucible-${crucible::version}.zip https://www.atlassian.com/software/crucible/downloads/binary/crucible-${crucible::version}.zip && /usr/bin/unzip /tmp/crucible-${crucible::version}.zip -d /tmp/ && mv /tmp/fecru-${crucible::version} ${crucible::install_dir}-${crucible::version} && chown -R ${crucible::service_user}.${crucible::service_user} ${crucible::install_dir}-${crucible::version}",
    creates => "${crucible::install_dir}-${crucible::version}",
    require => User[$crucible::service_user],
  }

  # symlink versioned directory with /opt/crucible/ directory name
  file { 'crucible_dir':
    ensure  => 'link',
    path    => $crucible::install_dir,
    owner   => $crucible::service_user,
    target  => "${crucible::install_dir}-${crucible::version}",
    require => User[$crucible::service_user],
  }

  # Create FISHETE_INST data directory
  file { 'fisheye_inst':
    ensure  => 'directory',
    path    => $crucible::fisheye_inst,
    owner   => $crucible::service_user,
    require => User[$crucible::service_user],
  }

}
