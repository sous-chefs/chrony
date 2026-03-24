# Chrony Cookbook Limitations

## Supported Platforms

The `chrony` cookbook supports the following Linux distributions:

- **RHEL / Rocky / AlmaLinux**: 9
- **CentOS Stream**: 9
- **Oracle Linux**: 9
- **Ubuntu**: 22.04 (LTS), 24.04 (LTS)
- **Debian**: 12
- **Amazon Linux**: 2023
- **Fedora**: Latest stable

## Package Availability

Chrony is available as a native package on all supported platforms:

- **Debian/Ubuntu**: `apt install chrony`
- **RHEL/CentOS/Rocky/Alma/Oracle/Fedora/Amazon**: `dnf install chrony`

No source compilation is required.

## Architecture Support

- x86_64
- aarch64 (ARM64)

## Migration from Recipes

As of the current version, this cookbook no longer provides `chrony::client` or `chrony::server`
recipes. Use the `chrony_config` custom resource directly in your wrapper cookbooks.

Users who previously relied on the Chef search feature in `chrony::client` (auto-discovering
nodes with `chrony::server` in their run list) must implement that logic in their own wrapper
cookbook.
