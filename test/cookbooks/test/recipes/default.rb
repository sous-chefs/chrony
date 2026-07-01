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

  directory '/etc/systemd/system/chronyd.service.d'

  systemd_unit 'chronyd.service.d/kitchen.conf' do
    content <<~UNIT
      [Service]
      Type=simple
    UNIT
    verify false
    action :create
    notifies :run, 'execute[systemctl daemon-reload]', :immediately
  end
end

chrony_config 'default' do
  extra_config ['log measurements statistics tracking']
end
