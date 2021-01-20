#
# Cookbook:: chrony
# Spec:: default
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

require 'spec_helper'

describe 'chrony::default' do
  context 'When all attributes are default' do
    context 'on Ubuntu 18.04' do
      cached(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '18.04').converge(described_recipe)
      end

      it 'included the client recipe' do
        expect(chef_run).to include_recipe('chrony::client')
      end
    end

    context 'on CentOS 7' do
      cached(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'centos', version: '7').converge(described_recipe)
      end

      it 'included the client recipe' do
        expect(chef_run).to include_recipe('chrony::client')
      end
    end
  end
end
