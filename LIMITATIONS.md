# Limitations

## Package Availability

### APT (Debian/Ubuntu)

- Debian 12 (EOL 2026-06-10): `chrony` is available from the standard repositories for amd64, arm64, armel, armhf, i386, mips64el, ppc64el, riscv64, and s390x.
- Debian 13 (EOL 2028-08-09): `chrony` is available from the standard repositories.
- Ubuntu 22.04 (EOL 2027-04-01) and 24.04 (EOL 2029-05-31): `chrony` is available from the standard Ubuntu repositories for amd64, arm64, armhf, ppc64el, riscv64, and s390x.

### DNF/YUM (RHEL family)

- RHEL 9, AlmaLinux 9 (EOL 2032-05-31), Rocky Linux 9 (EOL 2032-05-31), Oracle Linux 9 (EOL 2032-06-30), and CentOS Stream 9 (EOL 2027-05-31) provide `chrony` from their standard repositories.
- AlmaLinux 10 (EOL 2035-05-31), Rocky Linux 10 (EOL 2035-05-31), Oracle Linux 10, and CentOS Stream 10 (EOL 2030-01-01) provide `chrony` from their standard repositories.
- Amazon Linux 2023 (EOL 2029-06-30) provides `chrony` from the standard `dnf` repositories.
- Fedora latest provides `chrony` from the standard Fedora repositories.

## Architecture Limitations

- No cookbook-specific architecture restriction is currently known for supported platforms.
- The common deployment targets across the tested platforms are x86_64 and aarch64.

## Source/Compiled Installation

Chrony is installed from OS packages on all supported platforms in this cookbook. No source build path is implemented or required.

## Known Issues

- This cookbook does not manage vendor-specific repository setup because chrony is installed from the base OS repositories on supported platforms.
- Platform support in `metadata.rb` should stay aligned with `kitchen.yml`, `kitchen.dokken.yml`, and `kitchen.global.yml`.
