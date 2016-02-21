class crucible (
  $version = $crucible::params::version,
  $service_manage = $crucible::params::service_manage,
  $service_ensure = $crucible::params::service_ensure,
  $service_enable = $crucible::params::service_enable,
  $service_name = $crucible::params::service_name,
  $install_java = $crucible::params::install_java,
  $install_dir = $crucible::params::install_dir,
  $service_user = $crucible::params::service_user,
) inherits crucible::params {

  validate_re($version, '^*\.*\.*')
  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_string($service_name)
  validate_bool($install_java)
  validate_absolute_path($install_dir)
  validate_string($service_user)

  class { '::crucible::install': } ->
  class { '::crucible::config': } ~>
  class { '::crucible::service': }

}


