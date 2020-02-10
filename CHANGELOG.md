# chrony CHANGELOG

This file is used to list changes made in each version of the chrony cookbook.

## 0.3.0 (2020-02-10

- Added full support for CentOS/Redhat 7 & 8
- Expanded test coverage for Ubuntu, CentOS, and Redhat platforms
- Segregated templates used to configure chrony.conf for client and master servers

## 0.2.0 (2018-09-25)

- This cookbook has been brought back to life now under the chef-cookbooks org. Ideally, we'll rewrite this, but this version is already improved over the previous so we'll be releasing it now. Since this is not 1.0 expect heavy breaking changes in the future.
- Resolved all Foodcritic and Cookstyle warnings
- Added very basic ChefSpec
- Add Travis config + badge
- Added contributing and testing documentation
- Moved templates out of the default directory (chef 11-ism)
- Added name metadata
- Added chef_version metadata
- Added source_url and issues_url metadata
- Added a kitchen config
- Added a delivery local mode config
- Updated copyrights to be Chef Software not Opscode

## 0.1.0

Initial release.
