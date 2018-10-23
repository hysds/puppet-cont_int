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
  # install oracle java and set default
  #####################################################

  $jdk_rpm_file = "jdk-8u181-linux-x64.rpm"
  $jdk_rpm_path = "/etc/puppet/modules/cont_int/files/$jdk_rpm_file"
  $jdk_pkg_name = "jdk1.8"
  $jdk_pkg_dir = "jdk1.8.0_181-amd64"
  $java_bin_path = "/usr/java/$jdk_pkg_dir/jre/bin/java"


  cat_split_file { "$jdk_rpm_file":
    install_dir => "/etc/puppet/modules/cont_int/files",
    owner       =>  $user,
    group       =>  $group,
  }


  package { "$jdk_pkg_name":
    provider => rpm,
    ensure   => present,
    source   => $jdk_rpm_path,
    notify   => Exec['ldconfig'],
    require     => Cat_split_file["$jdk_rpm_file"],
  }


  update_alternatives { 'java':
    path     => $java_bin_path,
    require  => [
                 Package[$jdk_pkg_name],
                 Exec['ldconfig']
                ],
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


}
