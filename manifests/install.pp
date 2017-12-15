class crucible::install {

  # Install ansilary packages
  if $crucible::install_unzip == true {
    ensure_resource('package', 'unzip', {'ensure' => 'present'})
  }
  if $crucible::install_wget == true {
    ensure_resource('package', 'wget', {'ensure' => 'present'})
  }

  # Install Java
  if $crucible::install_java == true {

    case $::operatingsystem {
      'RedHat', 'CentOS': {

        class { 'java':
          distribution => 'jre',
          package      => 'java-1.8.0-openjdk',
        }
      }

      'Ubuntu':{
        include apt
        apt::ppa { 'ppa:openjdk-r/ppa': notify => Exec['apt_update'] }

        class { 'java':
          distribution => 'jre',
          package      => 'openjdk-8-jre',
          require      => Apt::Ppa['ppa:openjdk-r/ppa'],
        }
      }

      default: {
        fail("Module ${module_name} is not supported on ${::operatingsystem}")
      }
    }
  }

  # Setup service user
  user { $crucible::service_user:
    ensure     => present,
    home       => $crucible::homedir,
    managehome => true,
    shell      => '/bin/bash',
  }

  # Download and install the crucible directory if version file doesn't exist
  exec { 'install_crucible':
    command => "/usr/bin/wget -q -O /tmp/crucible-${crucible::version}.zip ${crucible::download_url}/crucible-${crucible::version}.zip && /usr/bin/unzip /tmp/crucible-${crucible::version}.zip -d /tmp/ && mv /tmp/fecru-${crucible::version} ${crucible::install_dir}-${crucible::version} && chown -R ${crucible::service_user}.${crucible::service_user} ${crucible::install_dir}-${crucible::version}",
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
