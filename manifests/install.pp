# Private Class
class znc::install inherits znc {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $package_name :
    ensure => $package_ensure,
  }

  if $user_manage {
    user { $user_name :
      ensure => $user_ensure,
      home   => $user_home,
      shell  => $user_shell,
    }
  }

}
