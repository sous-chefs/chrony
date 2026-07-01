# frozen_string_literal: true

apt_update

if platform_family?('rhel') && node['platform_version'].to_i >= 10
  package 'chrony'

  file '/etc/sysconfig/chronyd' do
    content %(# Command-line options for chronyd\nOPTIONS="-F 0"\n)
    owner 'root'
    group 'root'
    mode '0644'
  end
end

chrony_config 'default' do
  extra_config ['log measurements statistics tracking']
end
