# Private Class
class znc::service inherits znc {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if $service_manage {
    service { $service_name :
      ensure     => $service_ensure,
      hasrestart => true,
      hasstatus  => true,
      enable     => $service_ensure ? {
        '/running|true/' => true,
        '/stopped|false/' => false,
        default   => $service_ensure,
      },
    }
  }

}
