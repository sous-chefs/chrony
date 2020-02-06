#
# Cookbook:: chrony
# Libraries:: helpers
#
# Author: Dang H. Nguyen <dang.nguyen@disney.com>
# Copyright:: 2019, Chef Software, Inc <legal@chef.io>
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
def systemd?
  ::File.read('/proc/1/comm').strip == 'systemd'
end

def chrony_service_path
  value_for_platform_family(
    %w(rhel fedora) => '/usr/lib/systemd/system/chronyd.service',
    'default' => '/lib/systemd/system/chrony.service'
  )
end

def chrony_service_name
  value_for_platform_family(
    %w(rhel fedora) => 'chronyd',
    'default' => 'chrony'
  )
end

def chrony_conf_file
  value_for_platform_family(
    %w(rhel fedora) => '/etc/chrony.conf',
    'default' => '/etc/chrony/chrony.conf'
  )
end

# this detects whether the chef client is being executed in a docker container
# since chronyd might fail if the docker container does not have privileged access
# to the host (e.g., while be run in travis-ci container via kitchen-dokken),
# we need it to gracefully fail.
def running_in_docker?
  docker = Mixlib::ShellOut.new('grep docker /proc/self/cgroup').run_command
  !docker.stdout.empty?
end
