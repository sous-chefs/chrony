# frozen_string_literal: true

apt_update

directory '/var/run/chrony' do
  owner 'chrony'
  group 'chrony'
  mode '0755'
  recursive true
  only_if { platform_family?('rhel', 'fedora', 'amazon') }
end

chrony_config 'default' do
  extra_config ['log measurements statistics tracking']
end
