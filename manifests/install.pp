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
  if $crucible::user_manage == true {
    user { $crucible::service_user:
      ensure     => present,
      home       => $crucible::homedir,
      managehome => true,
      shell      => '/bin/bash',
    }
  }

  file { $crucible::install_dir:
    ensure => present,
    owner  => $crucible::service_user,
    group  => $crucible::service_user,
    mode   => '0755',
    before => Archive[$file],
  }

  # Download and install the crucible directory if version file doesn't exist
  $file = "crucible-${crucible::version}.zip"

  archive { $file:
    source          => "${crucible::download_url}/${file}",
    path            => "/tmp/$file",
    user            => $crucible::service_user,
    group           => $crucible::service_user,
    extract         => true,
    extract_path    => $crucible::install_dir,
    cleanup         => true,
    proxy_server    => $crucible::internet_proxy,
    allow_insecure  => true,
    creates         => "${crucible::install_dir}/fecru-${crucible::version}",
    require         => [ 
      User[$crucible::service_user],
      File[$crucible::install_dir],
    ]
  }

  # symlink versioned directory with /opt/crucible/ directory name
  if $crucible::create_symlink == true {
    file { 'crucible_dir':
      ensure  => 'link',
      path    => $crucible::install_dir,
      owner   => $crucible::service_user,
      target  => "${crucible::install_dir}-${crucible::version}",
      require => User[$crucible::service_user],
    }
  }

  # Create FISHETE_INST data directory
  file { 'fisheye_inst':
    ensure  => 'directory',
    path    => $crucible::fisheye_inst,
    owner   => $crucible::service_user,
    require => User[$crucible::service_user],
  }

}
