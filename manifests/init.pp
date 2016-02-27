class crucible (
  $version = '3.10.3',
  $service_manage = true,
  $service_ensure = 'running',
  $service_enable = true,
  $service_name = 'crucible',
  $service_user = 'crucible',
  $install_java = true,
  $install_dir = '/opt/crucible',
) {

  validate_re($version, '^*\.*\.*')
  validate_bool($service_manage)
  validate_string($service_ensure)
  validate_bool($service_enable)
  validate_string($service_name)
  validate_string($service_user)
  validate_bool($install_java)
  validate_absolute_path($install_dir)

  class { '::crucible::install': } ->
  class { '::crucible::config': } ~>
  class { '::crucible::service': }

}
