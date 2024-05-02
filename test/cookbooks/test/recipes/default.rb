# Workaround issue running chronyd in docker related to:
# https://access.redhat.com/solutions/4410831
directory '/var/run/chrony' if platform_family?('rhel')

node.override['chrony']['servers'] = { 'pool.ntp.org' => 'iburst' }
