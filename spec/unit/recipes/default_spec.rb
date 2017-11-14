#
# Cookbook Name:: jenkins
# Spec:: default
 
require 'spec_helper'

describe 'jenkins::default' do
  let(:chef_run) do
    # Ruby Class 
    ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
                          .converge(described_recipe)
  end
  # let(:chef_run) (ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04').converge(described_recipe)

  it 'installs Jenkins' do
                       #action_resource('name')  
    expect(chef_run).to install_package('jenkins')
  end

  it 'user created' do
    expect(chef_run).to create_user('jenkins')
  end

  it 'service are started' do
    expect(chef_run).to start_service('jenkins')
  end
  
  it 'service are enable' do
    expect(chef_run).to enable_service('jenkins')    
  end

  it 'file configuration' do
    expect(chef_run).to create_template('/etc/default/jenkins')
  end

end