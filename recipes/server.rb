# frozen_string_literal: true
#
# Cookbook:: chrony
# Recipe:: server
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

chrony_config 'server' do
  servers node['chrony']['servers']
  allow node['chrony']['allow']
  driftfile node['chrony']['driftfile']
  log_dir node['chrony']['log_dir']
  extra_config node['chrony']['extra_config']
end
