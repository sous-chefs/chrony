# chrony CHANGELOG

This file is used to list changes made in each version of the chrony cookbook.

## [1.2.8](https://github.com/sous-chefs/chrony/compare/v1.2.7...v1.2.8) (2025-12-01)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#65](https://github.com/sous-chefs/chrony/issues/65)) ([74bfaa6](https://github.com/sous-chefs/chrony/commit/74bfaa69a069001afa820ea9c360c55199649c55))

## [1.2.7](https://github.com/sous-chefs/chrony/compare/1.2.6...v1.2.7) (2025-10-15)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#65](https://github.com/sous-chefs/chrony/issues/65)) ([74bfaa6](https://github.com/sous-chefs/chrony/commit/74bfaa69a069001afa820ea9c360c55199649c55))

## 1.2.6 - *2025-09-04*

## 1.2.5 - *2024-05-02*

## 1.2.4 - *2024-05-02*

## 1.2.3 - *2023-03-02*

* Remove delivery workflow
* Add reusable workflow
* Add Markdownlint-cli2

## 1.2.1 - *2022-09-12*

* Remove delivery folder
* Fix issue with setting allow list in client recipe

## 1.2.0 - *2021-11-22*

* Reorder resources so Chrony is configured before it is started.

## 1.1.3 - *2021-11-17*

* Add missing yamllint and mdl checks to CI

## 1.1.2 - *2021-08-31*

* Standardise files with files in sous-chefs/repo-management

## 1.1.1 - *2021-06-01*

* Standardise files with files in sous-chefs/repo-management

## 1.1.0 - *2021-01-22*

* Conditionally search for masters

## 1.0.0 - *2021-01-21*

* Sous Chefs Adoption
* Standardize helpers library
* Improve testing
* Remove unused attributes
* Create attribute to handle custom extra configuration settings

## 0.3.1 (2020-12-23)

* Minor updates to the kitchen files and metadata.rb source fix - [@tas50](https://github.com/tas50)
* Use platform_family so we also support RHEL-like platforms like Oracle Linux - [@gsreynolds](https://github.com/gsreynolds)
* Cookstyle Bot Auto Corrections with Cookstyle 6.18.8 - [@cookstyle](https://github.com/cookstyle)

## 0.3.0 (2020-02-10

* Added full support for CentOS/Redhat 7 & 8
* Expanded test coverage for Ubuntu, CentOS, and Redhat platforms
* Segregated templates used to configure chrony.conf for client and master servers

## 0.2.0 (2018-09-25)

* This cookbook has been brought back to life now under the chef-cookbooks org. Ideally, we'll rewrite this, but this version is already improved over the previous so we'll be releasing it now. Since this is not 1.0 expect heavy breaking changes in the future.
* Resolved all Foodcritic and Cookstyle warnings
* Added very basic ChefSpec
* Add Travis config + badge
* Added contributing and testing documentation
* Moved templates out of the default directory (chef 11-ism)
* Added name metadata
* Added chef_version metadata
* Added source_url and issues_url metadata
* Added a kitchen config
* Added a delivery local mode config
* Updated copyrights to be Chef Software not Opscode

## 0.1.0

Initial release.
