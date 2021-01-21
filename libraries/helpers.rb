#
# Cookbook:: chrony
# Libraries:: helpers
#
# Author:: Dang H. Nguyen <dang.nguyen@disney.com>
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
module Chrony
  module Cookbook
    module Helpers
      def chrony_service_name
        if platform_family?('rhel', 'fedora', 'amazon')
          'chronyd'
        else
          'chrony'
        end
      end

      def chrony_conf_file
        if platform_family?('rhel', 'fedora', 'amazon')
          '/etc/chrony.conf'
        else
          '/etc/chrony/chrony.conf'
        end
      end
    end
  end
end
Chef::DSL::Recipe.include Chrony::Cookbook::Helpers
Chef::Resource.include Chrony::Cookbook::Helpers
