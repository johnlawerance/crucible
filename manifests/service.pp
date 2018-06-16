class crucible::service inherits crucible {

  if $crucible::service_manage == true {

    # Determine the service provider to use
    case $::osfamily {
      'Debian' : {
        case $::operatingsystem {
          'Ubuntu' : {
            if (versioncmp($::operatingsystemrelease, '15.04') >= 0) {
              $service_provider = 'systemd'
            } else {
              $service_provider = 'upstart'
            }
          }
          default: {
            if (versioncmp($::operatingsystemmajrelease, '8') >= 0) {
              $service_provider = 'systemd'
            } else {
              $service_provider = 'upstart'
            }
          }
        }
      }
      'RedHat' : {
        if (versioncmp($::operatingsystemmajrelease, '7') >= 0) {
          $service_provider = 'systemd'
        } else {
          $service_provider = 'upstart'
        }
      }
      default: {
        $service_provider = 'upstart'
      }
    }

    # Configure service
    if ($service_provider == 'systemd') {
      file { '/etc/systemd/system/crucible.service':
        ensure  => present,
        content => template('crucible/crucible.service.erb'),
        mode    => '0644',
      } ~>
      exec { 'crucible-systemd-reload-before-service':
        path        => ['/bin/', '/sbin/', '/usr/bin/', '/usr/sbin/'],
        command     => 'systemctl daemon-reload > /dev/null',
        notify      => Service['crucible'],
        refreshonly => true,
      }

    } else {
      file { '/etc/init.d/crucible':
        ensure  => file,
        content => template('crucible/crucible-init.sh.erb'),
        mode    => '0755',
        notify  => Service['crucible'],
      }
    }

    service { 'crucible':
      ensure     => $crucible::service_ensure,
      enable     => $crucible::service_enable,
      name       => $crucible::service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }
}
