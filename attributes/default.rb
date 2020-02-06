#
# Author:: Matt Ray <matt@@chef.io>
# Contributor:: Dang H. Nguyen <dang.nguyen@disney.com>
# Cookbook:: chrony
# Attributes:: default
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

# hash of default servers in the chrony.conf from Ubuntu
default['chrony']['servers'] = {
 'pool.ntp.org' => 'iburst',
}

default['chrony']['server_options'] = 'offline minpoll 8'

# set in the client & master recipes
# for better security, clients that do not need to serve ntp requests to peers or other clients
# should not have the `allow` directive in chrony.conf
# In this case, an empty array is the correct setting
# See https://chrony.tuxfamily.org/faq.html#_how_can_i_make_code_chronyd_code_more_secure
default['chrony']['allow'] = []

# set in the client & master recipes
default['chrony']['initslewstep'] = ''

default['chrony']['log_dir'] = '/var/log/chrony'
default['chrony']['driftfile'] = '/var/lib/chrony/drift'
default['chrony']['daemon_user'] = platform_family?('rhel') ? 'chrony' : '_chrony'

default['chrony']['systemd']['Unit'] = {
  'Description' => 'NTP client/server',
  'Documentation' => 'man:chronyd(8) man:chrony.conf(5)',
  'After' => 'ntpdate.service sntp.service ntpd.service',
  'Conflicts' => 'ntpd.service systemd-timesyncd.service',
  'ConditionCapability' => 'CAP_SYS_TIME',
}

# these are systemd settings that apply to all linux platforms
default['chrony']['systemd']['Service']['Type'] = 'forking'
default['chrony']['systemd']['Service']['PrivateTmp'] = 'yes'
default['chrony']['systemd']['Service']['ProtectHome'] = 'yes'
default['chrony']['systemd']['Service']['ProtectSystem'] = 'full'

# these are systemd configurations that are platform-specific
case node['platform']
when 'redhat', 'centos'
  default['chrony']['systemd']['Service']['PIDFile'] = '/run/chrony/chronyd.pid'
  default['chrony']['systemd']['Service']['EnvironmentFile'] = '-/etc/sysconfig/chronyd'
  default['chrony']['systemd']['Service']['ExecStart'] = '/usr/sbin/chronyd'
  default['chrony']['systemd']['Service']['ExecStartPost'] = '/usr/libexec/chrony-helper update-daemon'
when 'debian', 'ubuntu'
  default['chrony']['systemd']['Service']['PIDFile'] = '/run/chronyd.pid'
  default['chrony']['systemd']['Service']['EnvironmentFile'] = '-/etc/default/chrony'
  default['chrony']['systemd']['Service']['ExecStart'] = '/usr/lib/systemd/scripts/chronyd-starter.sh $DAEMON_OPTS'
  default['chrony']['systemd']['Service']['ExecStartPost'] = '-/usr/lib/chrony/chrony-helper update-daemon'
end

default['chrony']['systemd']['Install'] = {
  'Alias' => 'chronyd.service',
  'WantedBy' => 'multi-user.target',
}
