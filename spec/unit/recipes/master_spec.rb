#
# Cookbook:: chrony
# Spec:: client
#
# Author: Dang H. Nguyen <dang.nguyen@disney.com>
# Contributor:: Lance Albertson <lance@osuosl.org>
#
# Copyright:: 2020, The Walt Disney Company, All Rights Reserved
# Copyright:: 2020, Sous Chefs
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

require 'spec_helper'

describe 'chrony::master' do
  context 'on Ubuntu 18.04' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04').converge(described_recipe)
    end

    it_behaves_like 'chrony client'

    it 'rendered /etc/chrony/chrony.conf' do
      expect(chef_run).to render_file('/etc/chrony/chrony.conf').with_content(/server pool.ntp.org iburst/)
      expect(chef_run).to render_file('/etc/chrony/chrony.conf').with_content('allow')
    end
  end

  context 'on CentOS 7' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'centos', version: '7').converge(described_recipe)
    end

    it_behaves_like 'chrony client'

    it 'rendered /etc/chrony.conf' do
      expect(chef_run).to render_file('/etc/chrony.conf').with_content(/server pool.ntp.org iburst/)
      expect(chef_run).to render_file('/etc/chrony.conf').with_content('allow')
    end
  end
end
