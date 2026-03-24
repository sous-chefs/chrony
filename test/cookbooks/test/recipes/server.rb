# frozen_string_literal: true

apt_update

directory '/var/run/chrony' if platform_family?('rhel', 'fedora', 'amazon')

chrony_config 'server' do
  allow ['10.0.0.0/8']
end
