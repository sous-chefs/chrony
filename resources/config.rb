# frozen_string_literal: true
#
# Cookbook:: chrony
# Resource:: config
#
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
unified_mode true
provides :chrony_config

property :servers, Hash, default: { 'pool.ntp.org' => 'iburst' }
property :pools, Hash, default: {}
property :allow, Array, default: []
property :deny, Array, default: []
property :driftfile, String, default: lazy {
  platform_family?('rhel', 'fedora', 'amazon') ? '/var/lib/chrony/drift' : '/var/lib/chrony/chrony.drift'
}
property :log_dir, String, default: '/var/log/chrony'
property :extra_config, Array, default: []

action :create do
  package 'chrony'

  template chrony_conf_file do
    source 'chrony.conf.erb'
    cookbook 'chrony'
    owner 'root'
    group 'root'
    mode '0600'
    variables(
      servers: new_resource.servers,
      pools: new_resource.pools,
      allow: new_resource.allow,
      deny: new_resource.deny,
      driftfile: new_resource.driftfile,
      log_dir: new_resource.log_dir,
      extra_config: new_resource.extra_config
    )
    notifies :restart, "service[#{chrony_service_name}]", :delayed
  end

  service chrony_service_name do
    supports restart: true, status: true, reload: true
    action [:enable, :start]
  end
end

action :delete do
  service chrony_service_name do
    action [:stop, :disable]
  end

  package 'chrony' do
    action :remove
  end

  file chrony_conf_file do
    action :delete
  end
end

action_class do
  include Chrony::Cookbook::Helpers
end
