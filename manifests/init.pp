# == Class: znc
#
# Full description of class znc here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'znc':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2014 Your name here, unless otherwise noted.
#
class znc (
  $bind_ip        = '127.0.0.1',
  $default_port   = '5000',
  $package_ensure = 'present',
  $package_name   = 'znc',
  $service_ensure = 'running',
  $service_name   = 'znc',
  $service_manage = true,
  $global_modules = ['webadmin'],
  $user_ensure    = 'present',
  $user_name      = 'znc',
  $user_home      = '/var/lib/znc',
  $user_shell     = '/sbin/nologin',
  $config_file    = '/var/lib/znc/.znc/configs/znc.conf',
  $ipv4_enable    = true,
  $ipv6_enable    = true,
  $ssl_enable     = false,
) inherits znc::params {

  # Parameters validation
  validate_array($global_modules)
  validate_bool($service_manage, $ipv4_enable, $ipv6_enable, $ssl_enable)
  validate_string($user_name, $package_name, $bind_ip)
  validate_absolute_path($user_home, $user_shell)
  validate_re($package_ensure, ['^absent$', '^installed$', '^latest$', '^present$', '^[\d\.\-]+$'], "Invalid package_ensure variable: ${package_ensure}")
  validate_re($user_ensure, ['^absent$', '^role$', '^present$'], "Invalid user_ensure variable: ${user_ensure}")
  validate_re($service_ensure, ['^stopped$', '^false$', '^running$', '^true$'], "Invalid service_ensure variable: ${service_ensure}")

  if !is_integer($default_port) { fail('znc::default_port must be an integer') } 

  # Actual installation
  anchor { 'znc::begin' : } ->
  class { 'znc::install': } ->
  class { 'znc::config' : } ->
  class { 'znc::service' : } ->
  anchor { 'znc::end' : }

}
