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
