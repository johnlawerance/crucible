class crucible (
  $version = $crucible::params::version,
  $service_manage = $crucible::params::service_manage,
  $service_ensure = $crucible::params::service_ensure,
  $service_enable = $crucible::params::service_enable,
  $service_name = $crucible::params::service_name,
) inherits crucible::params {

  validate_re($version, '^*\.*\.*')
  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_string($service_name)


  class { '::crucible::install': } ->
  class { '::crucible::config': } ~>
  class { '::crucible::service': }

}


