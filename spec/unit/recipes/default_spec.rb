#
# Cookbook Name:: jenkins
# Spec:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.

require 'spec_helper'

describe command('curl  http://127.0.0.1:8080') do
  its(:stdout) { should match(/hudson.model.Hudson.Administer/) }
end