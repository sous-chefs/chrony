# Inspec test for recipe chrony::default
def systemd?
  pid_1_file = file('/proc/1/comm')
  pid_1_file.content.strip == 'systemd'
end

chrony_service = systemd? ? systemd_service('chronyd') : upstart_service('chrony')
chrony_conf_file = os.redhat? ? '/etc/chrony.conf' : '/etc/chrony/chrony.conf'

control 'chrony client' do
  title 'chrony client service'
  desc 'verify chrony daemon is installed and running'
  only_if { os.redhat? || os.debian? }

  # this will be used later to determine if testing is being run inside a docker container
  running_in_docker = command('grep docker /proc/self/cgroup')

  describe chrony_service do
    it { should be_installed }
    it { should be_enabled }
    it do
      skip if running_in_docker.exit_status == 0
      should be_running
    end
  end

  describe file(chrony_conf_file) do
    it { should be_file }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('mode') { should cmp '0644' }
    its('content') { should_not match(/allow.*/) }
  end
end
