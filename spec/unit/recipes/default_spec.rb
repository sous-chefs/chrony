#
# Cookbook:: chrony
# Spec:: default
#
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

describe 'chrony::default' do
  context 'When all attributes are default' do
    context 'on AlmaLinux 9' do
      cached(:chef_run) do
        ChefSpec::ServerRunner.new(platform: 'almalinux', version: '9').converge(described_recipe)
      end

      it 'included the client recipe' do
        expect(chef_run).to include_recipe('chrony::client')
      end
    end
  end
end
