Please refer to
https://github.com/chef-cookbooks/community_cookbook_documentation/blob/master/TESTING.MD

# Integration testing with kitchen-dokken
This cookbook attempts to fully integrate automated testing using the travis-ci testing framework. This
speeds up testing and ensures consistent results. However, chrony requires privileged access to the linux kernel,
which is not a supported feature of Travis-CI.

To this end, this cookbook provides two yaml configurations for Test Kitchen. One is based on a
vagrant VM testing model, which can be found in kitchen.yml, and the second one is based on kitchen-dokken,
which is found in kitchen.dokken.yml. Travis-CI will be configured to run tests against `kitchen.dokken.yml`.
The kitchen-dokken configuration will have chronyd not attempt to make updates to the system clock in order
to pass automated tests.

*Future contributors* should be aware that relying on travis-ci and the kitchen-dokken configuration
will not ensure that chronyd can be fully started/restarted during the exercise of test kitchen. An extra
step in your testing workflow should be to make sure that you run `kitchen verify` against the kitchen.yml
configuration. The latter, as of this writing, is able to start and restart chronyd in a vagrant VM.
