chrony_conf_file = if os.redhat? || os.name == 'fedora'
                     '/etc/chrony.conf'
                   else
                     '/etc/chrony/chrony.conf'
                   end

chrony_service = if os.redhat? || os.name == 'fedora'
                   'chronyd'
                 else
                   'chrony'
                 end

control 'chrony-server-01' do
  impact 1.0
  title 'chrony package is installed'
  desc 'The chrony package should be installed'

  describe package('chrony') do
    it { should be_installed }
  end
end

control 'chrony-server-02' do
  impact 1.0
  title 'chrony service is enabled and running'
  desc 'The chrony service should be enabled and running'

  describe service(chrony_service) do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'chrony-server-03' do
  impact 1.0
  title 'chrony server configuration file'
  desc 'The chrony configuration file should contain allow directives for server mode'

  describe file(chrony_conf_file) do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0600' }
    its('content') { should match(/^driftfile /) }
    its('content') { should match(%r{^allow 10\.0\.0\.0/8}) }
  end
end
