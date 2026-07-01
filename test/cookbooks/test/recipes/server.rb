# frozen_string_literal: true

apt_update

directory '/var/run/chrony' do
  owner 'chrony'
  group 'chrony'
  mode '0755'
  recursive true
  only_if { platform_family?('rhel', 'fedora', 'amazon') }
end

chrony_config 'server' do
  allow ['10.0.0.0/8']
end
