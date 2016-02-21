class crucible::params {

  # Default params values go here
  $version = '3.10.3'
  $service_manage = true
  $service_ensure = 'running'
  $service_enable = true
  $service_name = 'crucible'
  $install_java = true
  $install_dir = '/opt/crucible'
  $service_user = 'crucible'
}
