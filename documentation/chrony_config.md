# chrony_config

The `chrony_config` resource manages the chrony package, service, and configuration file.

## Actions

- `:create`: (default) Installs the chrony package, configures it, and enables/starts the service.
- `:delete`: Stops and disables the service, removes the package and configuration file.

## Properties

- `servers`: (Hash) A hash of NTP servers to use. Key is the server address, value is the options (e.g., `iburst`). Default: `{ 'pool.ntp.org' => 'iburst' }`.
- `pools`: (Hash) A hash of NTP pools to use. Key is the pool address, value is the options. Default: `{}`.
- `allow`: (Array) A list of addresses/subnets allowed to access the server. Default: `[]`.
- `deny`: (Array) A list of addresses/subnets denied access to the server. Default: `[]`.
- `driftfile`: (String) The path to the drift file. Default: Platform-specific.
- `log_dir`: (String) The directory for chrony logs. Default: `/var/log/chrony`.
- `extra_config`: (Array) A list of raw configuration strings to append to the config file. Default: `[]`.

## Examples

```ruby
chrony_config 'default' do
  servers({
    'ntp1.example.com' => 'iburst',
    'ntp2.example.com' => 'iburst',
  })
  allow ['192.168.1.0/24']
end
```
