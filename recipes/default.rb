#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

# wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
# sudo apt-get update
apt_repository 'jenkins' do
  uri          'http://pkg.jenkins.io/debian-stable'
  distribution 'binary/'
  key          'https://pkg.jenkins.io/debian/jenkins.io.key'
end

# sudo apt-get install jenkins
package 'jenkins' do
  action :install
end

user 'jenkins' do
  action :create
end

service 'jenkins' do
  action [:start, :enable]
  subscribes :restart, 'template[/etc/default/jenkins]', :immediately
end

# $ sudo ls -la /etc/default/jenkins 
# -rw-r--r-- 1 root root 2673 Nov  8 10:22 /etc/default/jenkins
template '/etc/default/jenkins' do
  source 'jenkins_ubuntu.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  #notifies :restart, 'service[jenkins]', :immediately
end

# remote_file '/tmp/jenkins.io.key' do
#   source 'https://pkg.jenkins.io/debian/jenkins.io.key'
#   # after download run "apt-key add" without delay 
#   notifies :run, 'execute[apt-key add /tmp/jenkins.io.key]', :immediately 
# end

# execute 'apt-key add /tmp/jenkins.io.key' do
#   # only run this command by notify  
#   action :nothing
# end

# file '/etc/apt/sources.list.d/jenkins.list' do
#   content 'deb http://pkg.jenkins.io/debian-stable binary/'
#   notifies :run, 'execute[sudo apt-get update]', :immediately
# end

# execute 'sudo apt-get update' do
#   action :nothing
# end
