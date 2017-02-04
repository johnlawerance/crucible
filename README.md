# crucible
[![Puppet Forge](https://img.shields.io/puppetforge/v/johnlawerance/crucible.svg)](https://forge.puppetlabs.com/johnlawerance/crucible)
[![Build Status](https://travis-ci.org/johnlawerance/crucible.svg?branch=master)](https://github.com/johnlawerance/crucible)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with crucible](#setup)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs, configures, and manages Atlassian Crucible / Fisheye.

## Setup

### What crucible affects

* Atlassian Crucible / Fisheye
* Java installation

### Beginning with crucible

Basic install using default settings.

```puppet
class { ::crucible }
```

## Usage

All interactions with the crucible module can be performed through the main crucible class.

### Minimal installation using default settings:
```puppet
class { ::crucible }
```

### Install Crucible 3.10.2 and change the install location and service user:
```puppet
class { ::crucible
  version      => '3.10.2'
  install_dir  => '/usr/local/crucible'
  service_user => 'fisheye'
}
```

### Install Crucible, don't manage the service, and don't install java:
```puppet
class { ::crucible
  service_manage => false
  install_java   => false
}
```

## Reference

### Public Classes

* crucible: Main class, includes all other classes.

#### Private Classes

* crucible::install: Handles the packages.
* crucible::config: Handles the configuration file.
* crucible::service: Handles the service.

### Module Parameters

#### `version`
Which version of Crucible to install (default: 4.0.3)
#### `service_manage`
Should puppet manage the init service? (default: true)
#### `service_ensure`
State the service should be (default: running, valid options: running, stopped)
#### `service_enable`
Should the service be enabled on boot? (default: true)
#### `service_name`
Name of the service (default: crucible)
#### `install_java`
Should the module install Java? (default: true)
#### `install_dir`
Where should crucible be installed? (default: '/opt/crucible')
#### `fisheye_inst`
Where should crucible's data be stored? (default: '/opt/crucible-data')
#### `service_user`
What user should the service run under? (default: crucible)
#### `install_unzip`
Should the module install unzip? (default: true)
#### `install_wget`
Should the module install wget? (default: true)
#### `download_url`
Specify alternate download URL (default: 'https://www.atlassian.com/software/crucible/downloads/binary')


## Limitations

### OSes Supported:
* RHEL/CentOS 6
* Ubuntu 12.04, 14.04

### Dependencies:
* puppetlabs-stdlib >= 3.0.0
* puppetlabs-java >= 1.2.0
* puppetlabs-apt >= 1.4.0 (Only required for Ubuntu)


This module has only been tested on CentOS6, Ubuntu 12.04, and Ubuntu 14.04 using OpenJRE8 on Puppet Enterprise 2015.3

## Development

Please feel free to ask (or submit PRs) for feature requests, improvements, etc!
