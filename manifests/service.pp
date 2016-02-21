class crucible::service inherits crucible {

  if $service_manage == true {

    file { '/etc/init.d/crucible':
      ensure  => file,
      content => template('crucible/crucible-init.sh.erb'),
      mode    => '755',
    }

    service { 'crucible':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
      require => File['/etc/init.d/crucible'],
    }
  }

}
