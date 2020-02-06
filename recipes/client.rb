#
# Author:: Matt Ray <matt@@chef.io>
# Contributor:: Dang H. Nguyen <dang.nguyen@disney.com>
# Cookbook:: chrony
# Recipe:: client
# Copyright:: 2011-2019 Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package 'chrony'

file '/etc/systemd/system/multi-user.target.wants/chronyd.service' do
  action :delete
  only_if { systemd? }
end

systemd_unit "#{chrony_service_name}.service" do
  action %i(create enable)
  content node['chrony']['systemd']
  verify false
  only_if { systemd? }
end

service 'chrony' do
  service_name chrony_service_name
  supports restart: true, status: true, reload: true
  if systemd? && running_in_docker?
    start_command "systemctl --no-block start #{chrony_service_name}"
    restart_command "systemctl --no-block restart #{chrony_service_name}"
  end
  action %i(start enable)
end

# search for the chrony master(s), if found populate the template accordingly
# typical deployment will only have 1 master, but still allow for multiple
masters = search(:node, 'recipes:chrony\:\:master') || []
if masters.empty?
  Chef::Log.info("No chrony master(s) found, using node['chrony']['servers'] attribute.")
else
  node.default['chrony']['servers'] = {}
  masters.each do |master|
    node.default['chrony']['servers'][master['ipaddress']] = master['chrony']['server_options']
    node.default['chrony']['allow'].push "allow #{master['ipaddress']}"
    # only use 1 server to sync initslewstep
    node.default['chrony']['initslewstep'] = "initslewstep 20 #{master['ipaddress']}"
  end
end

template 'chrony.conf' do
  path chrony_conf_file
  source 'chrony_client.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables driftfile: node['chrony']['driftfile'],
            log_dir: node['chrony']['log_dir'],
            servers: node['chrony']['servers']
  notifies :restart, 'service[chrony]'
end
