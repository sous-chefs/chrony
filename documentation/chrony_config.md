# chrony_config

The `chrony_config` resource manages the chrony package, service, and configuration file.

## Actions

| Action | Description |
|---|---|
| `:create` | Installs the chrony package, manages the configuration file, and enables and starts the service. Default action. |
| `:delete` | Stops and disables the service, removes the package, and deletes the configuration file. |

## Properties

| Property | Type | Default | Description |
|---|---|---|---|
| `servers` | Hash | `{ 'pool.ntp.org' => 'iburst' }` | NTP servers to configure, keyed by hostname with option strings as values. |
| `pools` | Hash | `{}` | NTP pools to configure, keyed by hostname with option strings as values. |
| `allow` | Array | `[]` | Networks or hosts allowed to query the local chrony server. |
| `deny` | Array | `[]` | Networks or hosts denied access to the local chrony server. |
| `driftfile` | String | platform-specific | Drift file path. Defaults to `/var/lib/chrony/drift` on RHEL family and `/var/lib/chrony/chrony.drift` on Debian family. |
| `log_dir` | String | `'/var/log/chrony'` | Directory used for chrony log output. |
| `extra_config` | Array | `[]` | Raw configuration lines appended to the generated chrony configuration file. |

## Examples

### Basic usage

```ruby
chrony_config 'default' do
  action :create
end
```

### Server configuration

```ruby
chrony_config 'server' do
  servers(
    'ntp1.example.com' => 'iburst',
    'ntp2.example.com' => 'iburst'
  )
  allow ['192.168.1.0/24']
  action :create
end
```
