chrony_conf_file = if os.redhat? || os.name == 'rocky' || os.name == 'almalinux'
                     '/etc/chrony.conf'
                   else
                     '/etc/chrony/chrony.conf'
                   end

chrony_service = if os.redhat? || os.name == 'rocky' || os.name == 'almalinux'
                   'chronyd'
                 else
                   'chrony'
                 end

chrony_type = input('type', value: 'client')

control 'chrony' do
  describe package 'chrony' do
    it { should be_installed }
  end

  describe service chrony_service do
    it { should be_enabled }
    it { should be_running }
  end

  describe file chrony_conf_file do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should match /^driftfile .*/ }

    if chrony_type == 'client'
      its('content') { should match /^log measurements statistics tracking$/ }
    else
      its('content') { should match /^allow .*/ }
    end
  end
end
