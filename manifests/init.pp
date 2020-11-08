
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

         $customtaskimports = $::kesl::customtaskimports[$task]

         file { $taskfilepath:
         ensure  => file,
         owner   => 'root',
         group   => 'root',
         mode    => '0644',
         content => template('kesl/kesl_task.ini.erb'),
         notify  => Exec['set_task_settings'] 
         }

         exec { 'set_task_settings':
           path    =>  ["/usr/bin", "/usr/sbin", "/bin"],
           command => "kesl-control --set-settings ${task} --file ${taskfilepath}"
         }
}


class kesl (

  $package_name = 'kesl',
  $ensure = 'latest',
  $service_name = 'kesl',
  $service_run = true,
  $service_enable = true,
  $confpath = '/opt/kaspersky/kesl/kesl.ini',
  $fullconfpath = '/opt/kaspersky/kesl/kesl_full.ini',
  $customconfpath = '/opt/kaspersky/kesl/custom_kesl.ini',
  $autoinstall = $::kesl::autoinstall,
  $customimports = $::kesl::customimports,
  $customtaskimports = $::kesl::customtaskimports,
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

  file { $customconfpath:
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template('kesl/custom_kesl.ini.erb'),
    notify  => Exec['apply_config']
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

  $tasks = keys($customtaskimports)
  tasks::set_settings_task { $tasks:; }

  service { $service_name:
    ensure => $service_run,
    enable => $service_enable,
    require => Package[$package_name],
    notify => Exec['save_full_config']
  }
}
