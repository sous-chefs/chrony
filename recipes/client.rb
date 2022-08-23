#
# Author:: Matt Ray <matt@@chef.io>
# Contributor:: Dang H. Nguyen <dang.nguyen@disney.com>
# Contributor:: Lance Albertson <lance@osuosl.org>
# Cookbook:: chrony
# Recipe:: client
# Copyright:: 2011-2020, Chef Software, Inc.
# Copyright:: 2020, Sous Chefs
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

# search for the chrony master(s), if found populate the template accordingly
# typical deployment will only have 1 master, but still allow for multiple
masters = search(:node, 'recipes:chrony\:\:master') if node['chrony']['search_masters']
masters ||= []
if masters.empty?
  Chef::Log.info("No chrony master(s) found, using node['chrony']['servers'] attribute.")
else
  node.default['chrony']['servers'] = {}
  masters.each do |master|
    node.default['chrony']['servers'][master['ipaddress']] = master['chrony']['server_options']
    node.default['chrony']['allow'].push "allow #{master['ipaddress']}"
  end
end

template 'chrony.conf' do
  path chrony_conf_file
  source 'chrony_client.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables allow: node['chrony']['allow'],
            driftfile: node['chrony']['driftfile'],
            log_dir: node['chrony']['log_dir'],
            servers: node['chrony']['servers']
  notifies :restart, 'service[chrony]', :delayed
end

service 'chrony' do
  service_name chrony_service_name
  supports restart: true, status: true, reload: true
  action %i(start enable)
end
