#
# Cookbook Name:: jenkins
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

# wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
remote_file '/tmp/jenkins.io.key' do
  source 'https://pkg.jenkins.io/debian/jenkins.io.key'
  # after download run "apt-key add" without delay 
  notifies :run, 'execute[apt-key add /tmp/jenkins.io.key]', :immediately 
end

execute 'apt-key add /tmp/jenkins.io.key' do
  # only run this command by notify  
  action :nothing
end

# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
file '/etc/apt/sources.list.d/jenkins.list' do
  content 'deb http://pkg.jenkins.io/debian-stable binary/'
  notifies :run, 'execute[sudo apt-get update]', :immediately
end


# sudo apt-get update
execute 'sudo apt-get update' do
  action :nothing
end

# sudo apt-get install jenkins
package 'jenkins' do
  action :install
end

