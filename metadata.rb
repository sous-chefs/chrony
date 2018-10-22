name             'chrony'
maintainer       'Chef Software, Inc..'
maintainer_email 'cookbooks@@chef.io'
license          'Apache-2.0'
description      'Installs/Configures chrony, an application used to maintain the accuracy of the system clock (similar to NTP).'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.1'
chef_version     '>= 13.0'
issues_url 'https://github.com/chef-cookbook/chrony/issues'
source_url 'https://github.com/chef-cookbook/chrony'

%w( debian ubuntu ).each do |os|
  supports os
end
