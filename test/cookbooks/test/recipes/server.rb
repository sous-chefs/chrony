# frozen_string_literal: true

apt_update

if (platform_family?('rhel') && node['platform_version'].to_i >= 10) || platform_family?('amazon')
  package 'chrony'

  file '/etc/sysconfig/chronyd' do
    content %(# Command-line options for chronyd\nOPTIONS="-x -F 0"\n)
    owner 'root'
    group 'root'
    mode '0644'
  end
end

if platform_family?('rhel') && node['platform_version'].to_i >= 10
  execute 'systemctl daemon-reload' do
    action :nothing
  end

  systemd_unit 'chronyd.service.d/kitchen.conf' do
    content <<~UNIT
      [Service]
      Type=simple
    UNIT
    action :create
    notifies :run, 'execute[systemctl daemon-reload]', :immediately
  end
end

chrony_config 'server' do
  allow ['10.0.0.0/8']
end
