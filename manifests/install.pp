class crucible::install inherits crucible {

  # exec to download and install the crucible directory if version file doesn't exist
  exec { 'install_crucible':
    command => "wget -q -O /tmp/crucible-$version.zip https://www.atlassian.com/software/crucible/downloads/binary/crucible-$version.zip && unzip /tmp/crucible-$version.zip -d /tmp/ && mv /tmp/fecru-$version /opt/crucible-$version",
    creates => "/opt/crucible-$version",
  }

  # symlink versioned directory with /opt/crucible/ directory name
  file { 'crucible_dir':
    path   => '/opt/crucible',
    ensure => 'link',
    target => "/opt/crucible-$version"
  }

}
