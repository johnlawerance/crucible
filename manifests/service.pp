class crucible::service inherits crucible {

  if $service_manage == true {
    service { 'crucible':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $service_name,
      hasstatus  => true,
      hasrestart => true,
    }
  }

}
