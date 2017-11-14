# # encoding: utf-8

# Inspec test for recipe jenkins::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

unless os.windows?
  describe user('root') do
    it { should exist }
    skip 'This is an example test, replace with your own test.'
  end
end

describe port(8080) do
  it { should be_listening }
  its('processes') { should include 'java' }
  its('protocols') { should include 'tcp' }
  its('addresses') { should include '0.0.0.0' }
  #its('protocols') { should include 'tcp6' }
  #its('addresses') { should include '::' }
end

describe command('curl http://localhost:8080') do
  #its(stdout) { should match /hudson/ }
  its('stdout') { should match (/hudson/) }
end