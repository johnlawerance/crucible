class crucible::service inherits crucible {

  if $crucible::service_manage == true {

    file { '/etc/init.d/crucible':
      ensure  => file,
      content => template('crucible/crucible-init.sh.erb'),
      mode    => '0755',
    }

    service { 'crucible':
      ensure     => $crucible::service_ensure,
      enable     => $crucible::service_enable,
      name       => $crucible::service_name,
      hasstatus  => true,
      hasrestart => true,
      require    => File['/etc/init.d/crucible'],
    }
  }

}
