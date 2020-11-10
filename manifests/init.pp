
#
# == Class: kesl
#

define tasks::set_settings_task {
         $task = $name
         $taskfilepath = "/tmp/settings-task.ini.${task}"

         #
         # Debug
         #
         #notify { 'CustomTaskImports':
         #withpath => true,
         #name     => "${::kesl::customtaskimports[$task]}",
         #}

         if $customtaskimports {
         $customtaskimports = $::kesl::customtaskimports[$task]
         
         file { $taskfilepath:
         ensure  => file,
         owner   => 'root',
         group   => 'root',
         mode    => '0644',
         content => template('kesl/kesl_task.ini.erb'),
         notify  => Exec['set_task_settings'] 
          }
         }  
 
         exec { 'set_task_settings':
           path    =>  ["/usr/bin", "/usr/sbin", "/bin"],
           command => "kesl-control --set-settings ${task} --file ${taskfilepath}"
         }
}


class kesl (

  $package_name = 'kesl',
  $packageagent_name = 'klnagent64',
  $ensure = 'latest',
  $ensureagent = 'latest',
  $service_name = 'kesl',
  $service_run = true,
  $service_enable = true,
  $serviceagent_name = "${packageagent_name}",
  $serviceagent_run = true,
  $serviceagent_enable = true,
  $agentconfpath = "/opt/kaspersky/${packageagent_name}/kesl_agent.ini",
  $confpath = '/opt/kaspersky/kesl/kesl.ini',
  $fullconfpath = '/opt/kaspersky/kesl/kesl_full.ini',
  $customconfpath = '/opt/kaspersky/kesl/custom_kesl.ini',
  $autoinstall = $::kesl::autoinstall,
  $autoinstallagent = $::kesl::autoinstallagent,
  $customimports = hiera('kesl::customimports',undef),
  $customtaskimports = hiera('kesl::customtaskimports',undef),
  $customconfigversion = '11.1.0.3013',

) {

  package { $package_name:
    ensure => $ensure,
    notify => Exec['init_config']
  }
  ~>
  file { $confpath:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kesl/kesl.ini.erb'),
    notify  => Exec['apply_config']
  }

  
  if $customimports {
  file { $customconfpath:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kesl/custom_kesl.ini.erb'),
    notify  => Exec['apply_config']
   }
  }

  exec { 'save_full_config':
    command => "kesl-control --export-settings --file ${fullconfpath}",
    path    => ['/usr/bin', '/bin', '/usr/sbin']
  }

  exec { 'init_config':
    command => "/opt/kaspersky/kesl/bin/kesl-setup.pl --autoinstall=${confpath}",
    path    => ['/usr/bin', '/bin', '/usr/sbin'],
    refreshonly => true,
    notify => Service[$service_name]
  }

  exec { 'apply_config':
       command     => "kesl-control --import-settings --file ${customconfpath}",
       path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
       refreshonly => true,
       notify      => Service[$service_name]
  }

  if $customtaskimports {
  $tasks = keys($customtaskimports)
  tasks::set_settings_task { $tasks:; }
  }

  service { $service_name:
    ensure => $service_run,
    enable => $service_enable,
    require => Package[$package_name],
    notify => Exec['save_full_config']
  }


  package { $packageagent_name:
  ensure => $ensureagent
  }
  ~>
  if $ensureagent != 'absent' {
  file { $agentconfpath:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kesl/kesl_agent.ini.erb'),
    notify  => Exec['init_agent_config']
   }

  exec { 'init_agent_config':
    environment => ["KLAUTOANSWERS=${agentconfpath}"],
    command => "/opt/kaspersky/${packageagent_name}/lib/bin/setup/postinstall.pl",
    path    => ['/usr/bin', '/bin', '/usr/sbin'],
    refreshonly => true,
    notify => Exec['apply_agent_config']
   }

  exec { 'apply_agent_config':
       command     => "/opt/kaspersky/${packageagent_name}/sbin/klnagent -reload-connectors",
       path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
       refreshonly => true
   }

  service { $serviceagent_name:
    ensure => $serviceagent_run,
    enable => $serviceagent_enable,
    require => Package[$packageagent_name]
   }
  }

}
