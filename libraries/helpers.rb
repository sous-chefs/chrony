#
# Cookbook:: chrony
# Libraries:: helpers
#
# Author: Dang H. Nguyen <dang.nguyen@disney.com>
# Copyright:: 2020, The Walt Disney Company, All Rights Reserved
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# this systemd? helper method might collide with Chef Infra Client >= 15.5
# leaving here for older Chef Infra Clients
unless respond_to?(:systemd?)
  def systemd?
    ::File.exist?('/proc/1/comm') && ::File.new('/proc/1/comm').gets.chomp == 'systemd'
  end
end

def chrony_service_path
  value_for_platform_family(
    %w(rhel fedora amazon) => '/usr/lib/systemd/system/chronyd.service',
    'default' => '/lib/systemd/system/chrony.service'
  )
end

def chrony_service_name
  value_for_platform_family(
    %w(rhel fedora amazon) => 'chronyd',
    'default' => 'chrony'
  )
end

def chrony_conf_file
  value_for_platform_family(
    %w(rhel fedora amazon) => '/etc/chrony.conf',
    'default' => '/etc/chrony/chrony.conf'
  )
end
