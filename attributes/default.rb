#
# Author:: Matt Ray <matt@@chef.io>
# Contributor:: Dang H. Nguyen <dang.nguyen@disney.com>
# Contributor:: Lance Albertson <lance@osuosl.org>
# Cookbook:: chrony
# Attributes:: default
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

# hash of default servers in the chrony.conf from Ubuntu
default['chrony']['servers'] = {
  'pool.ntp.org' => 'iburst',
}

default['chrony']['server_options'] = 'offline minpoll 8'

# Use servers including recipe chrony::master registered in Chef server
# to populate our servers list.
default['chrony']['search_masters'] = true

# set in the client & master recipes
# for better security, clients that do not need to serve ntp requests to peers or other clients
# should not have the `allow` directive in chrony.conf
# In this case, an empty array is the correct setting
# See https://chrony.tuxfamily.org/faq.html#_how_can_i_make_code_chronyd_code_more_secure
default['chrony']['allow'] = []

default['chrony']['log_dir'] = '/var/log/chrony'
default['chrony']['driftfile'] = '/var/lib/chrony/drift'

# Extra configuration values to be added directly to chrony.conf
default['chrony']['extra_config'] = []
