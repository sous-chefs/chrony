#
# Author:: Matt Ray <matt@@chef.io>
# Cookbook Name:: chrony
# Attributes:: default
# Copyright:: 2011-2018 Chef Software, Inc.
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

# hash of default servers in the chrony.conf
case node['platform']
when 'debian', 'ubuntu', 'centos'
  default['chrony']['servers'] = {
    "0.#{node['platform']}.pool.ntp.org" => 'offline minpoll 8',
    "1.#{node['platform']}.pool.ntp.org" => 'offline minpoll 8',
    "2.#{node['platform']}.pool.ntp.org" => 'offline minpoll 8',
    "3.#{node['platform']}.pool.ntp.org" => 'offline minpoll 8',
  }
when 'rhel'
  default['chrony']['servers'] = {
    '0.rhel.pool.ntp.org' => 'offline minpoll 8',
    '1.rhel.pool.ntp.org' => 'offline minpoll 8',
    '2.rhel.pool.ntp.org' => 'offline minpoll 8',
    '3.rhel.pool.ntp.org' => 'offline minpoll 8',
  }
else
  default['chrony']['servers'] = {
    '0.pool.ntp.org' => 'offline minpoll 8',
    '1.pool.ntp.org' => 'offline minpoll 8',
    '2.pool.ntp.org' => 'offline minpoll 8',
    '3.pool.ntp.org' => 'offline minpoll 8',
  }
end

default['chrony']['service'] = if node['platform_family'] == 'rhel'
                                 'chronyd'
                               else
                                 'chrony'
                               end

default['chrony']['server_options'] = 'offline minpoll 8'

# set in the client & master recipes
default['chrony']['allow'] = ['allow']

# set in the client & master recipes
default['chrony']['initslewstep'] = ''
