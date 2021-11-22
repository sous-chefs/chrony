# chrony cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/chrony.svg)](https://supermarket.chef.io/cookbooks/chrony)
[![CI State](https://github.com/sous-chefs/chrony/workflows/ci/badge.svg)](https://github.com/sous-chefs/chrony/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

Configures the time synchronization application `chrony` as a client or master timeserver, maintaining the accuracy of the system clock (similar to NTP). Isolated networks are supported as well.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working together to maintain important cookbooks. If you’d like to know more please visit [sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in [#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

- Debian / Ubuntu
- CentOS / Redhat

### Chef

- Chef 13+

## Recipes

### client

Configures the node to use the `chrony` application to keep the node's clock synced. If there is a node using the `chrony::master` recipe, the client will attempt to sync with it, unless disabled via `['chrony']['search_masters']`. If there is not an available master, the attribute list `['chrony'][:servers]` is used (defaults are `[0-3].debian.pool.ntp.org`). If there is a master node, the `['chrony'][:allowed]` will be set to allow for syncing with the master.

### default

The default recipe passes through to the client recipe.

### master

The node will use the `chrony` application to provide time to nodes using the `chrony::client` recipe. The master sets its own time against the attribute list `['chrony'][:servers]` (defaults are `[0-3].debian.pool.ntp.org`). Access to this master is restricted by the `['chrony'][:allowed]` attribute set in the recipe (default is to the `x.y.*` subnet).

## Usage

Nodes using the `chrony::client` recipe will attempt to sync time with nodes using the `chrony::master` recipe. If there are no `chrony::master` nodes found, the contents of the attribute list `['chrony'][:servers]` are used (defaults are `[0-3].debian.pool.ntp.org`).

The current configurations are supported:
1) Clients with direct NTP server access
2) A master with direct NTP server access with clients pointing to it

## Contributors

This project exists thanks to all the people who [contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)
