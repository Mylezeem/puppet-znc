# Private Class
class znc::config {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  concat { $config_file :
    ensure => 'present',
    owner  => $user_name,
    group  => $user_name,
    mode   => '0600',
  }

  concat::fragment { 'header' :
    target  => $config_file,
    content => template('znc/header.erb'),
    order   => '01',
  }

}
