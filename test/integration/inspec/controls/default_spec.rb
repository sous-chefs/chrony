chrony_conf_file = os.redhat? ? '/etc/chrony.conf' : '/etc/chrony/chrony.conf'
chrony_type = input('type')

control 'chrony' do
  describe service 'chronyd' do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

  describe file chrony_conf_file do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
    if chrony_type == 'client'
      its('content') { should_not match(/allow.*/) }
    else
      its('content') { should match(/allow.*/) }
    end
  end
end
