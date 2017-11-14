#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

apt_repository 'jenkins' do
  uri          'http://pkg.jenkins.io/debian-stable'
  distribution 'binary/'
  key          'https://pkg.jenkins.io/debian/jenkins.io.key'
end

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

template '/etc/default/jenkins' do
  source 'jenkins_ubuntu.erb'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  #notifies :restart, 'service[jenkins]', :immediately
end