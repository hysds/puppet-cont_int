#####################################################
# cont_int class
#####################################################

class cont_int inherits verdi {

  #####################################################
  # jenkins directory
  #####################################################

  $jenkins_dir = "/home/$user/jenkins"


  #####################################################
  # write rc.local to startup & shutdown cont_int
  #####################################################

  file { '/etc/rc.d/rc.local':
    ensure  => file,
    content  => template('cont_int/rc.local'),
    mode    => 0755,
  }


  #####################################################
  # install jenkins war and plugins
  #####################################################

  file { ["$jenkins_dir",
          "$jenkins_dir/bin",
          "$jenkins_dir/src",
          "$jenkins_dir/etc",
          "$jenkins_dir/plugins"]:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => 0755,
    require => User[$user],
  }


  cat_split_file { "jenkins.war":
    install_dir => "/etc/puppet/modules/cont_int/files",
    owner       =>  $user,
    group       =>  $group,
  }


  file { "/usr/local/bin/jenkins.war":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0755,
    source  => "puppet:///modules/cont_int/jenkins.war",
    require => Cat_split_file['jenkins.war'],
  }


  file { "$jenkins_dir/plugins/ace-editor.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/ace-editor.jpi",
  }


  file { "$jenkins_dir/plugins/authorize-project.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/authorize-project.jpi",
  }


  file { "$jenkins_dir/plugins/branch-api.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/branch-api.jpi",
  }


  file { "$jenkins_dir/plugins/cloudbees-folder.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/cloudbees-folder.jpi",
  }


  file { "$jenkins_dir/plugins/durable-task.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/durable-task.jpi",
  }


  file { "$jenkins_dir/plugins/ghprb.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/ghprb.jpi",
  }


  file { "$jenkins_dir/plugins/git-client.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/git-client.jpi",
  }


  file { "$jenkins_dir/plugins/github-api.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/github-api.jpi",
  }


  file { "$jenkins_dir/plugins/github-branch-source.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/github-branch-source.jpi",
  }


  file { "$jenkins_dir/plugins/github.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/github.jpi",
  }


  file { "$jenkins_dir/plugins/github-oauth.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/github-oauth.jpi",
  }


  file { "$jenkins_dir/plugins/github-organization-folder.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/github-organization-folder.jpi",
  }


  file { "$jenkins_dir/plugins/git.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/git.jpi",
  }


  file { "$jenkins_dir/plugins/icon-shim.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/icon-shim.jpi",
  }


  file { "$jenkins_dir/plugins/jquery-detached.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/jquery-detached.jpi",
  }


  file { "$jenkins_dir/plugins/mapdb-api.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/mapdb-api.jpi",
  }


  file { "$jenkins_dir/plugins/plain-credentials.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/plain-credentials.jpi",
  }


  file { "$jenkins_dir/plugins/scm-api.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/scm-api.jpi",
  }


  file { "$jenkins_dir/plugins/shiningpanda.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/shiningpanda.jpi",
  }


  file { "$jenkins_dir/plugins/ssh-agent.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/ssh-agent.jpi",
  }


  file { "$jenkins_dir/plugins/structs.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/structs.jpi",
  }


  file { "$jenkins_dir/plugins/token-macro.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/token-macro.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-api.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-api.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-cps.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-cps.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-job.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-job.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-multibranch.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-multibranch.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-scm-step.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-scm-step.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-step-api.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-step-api.jpi",
  }


  file { "$jenkins_dir/plugins/workflow-support.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/workflow-support.jpi",
  }


  file { "$jenkins_dir/plugins/embeddable-build-status.jpi":
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => 0644,
    source  => "puppet:///modules/cont_int/embeddable-build-status.jpi",
  }


  #####################################################
  # jenkins service
  #####################################################

  file { '/etc/systemd/system/jenkins.service':
    ensure  => present,
    mode    => 0644,
    content => template('cont_int/jenkins.service'),
    require => File['/usr/local/bin/jenkins.war'],
    notify  => Exec['daemon-reload'],
  }


  service { 'jenkins':
    ensure  => running,
    enable  => true,
    require => [
                File['/etc/systemd/system/jenkins.service'],
                Exec['daemon-reload'],
               ],
  }


  #####################################################
  # override index.html and ssl.conf from verdi
  #####################################################

  File['/var/www/html/index.html'] {
    ensure  => file,
    content => template('cont_int/index.html'),
    mode    => 0644,
    require => Package['httpd'],
  }


  file { "/etc/httpd/conf.d/ssl.conf":
    ensure  => present,
    content => template('cont_int/ssl.conf'),
    mode    => 0644,
    require => Package['httpd'],
  }


  #####################################################
  # override firewalld config from verdi
  #####################################################

  Firewalld::Zone['public'] {
    services => [ "ssh", "dhcpv6-client", "http", "https" ],
    ports => [
      {
        # Jenkins
        port     => "8080",
        protocol => "tcp",
      },
    ]
  }


  #firewalld::service { 'dummy':
  #  description	=> 'My dummy service',
  #  ports       => [{port => '1234', protocol => 'tcp',},],
  #  modules     => ['some_module_to_load'],
  #  destination	=> {ipv4 => '224.0.0.251', ipv6 => 'ff02::fb'},
  #}


}
