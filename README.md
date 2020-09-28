
&nbsp;

<p align="center">
    <img alt="Sappi" title="Sappi" src="Assets/logo.svg" height="200">
</p>
<h1 align="center">Sappi</h1>

Command Line Tool for Gathering System Information using Swift Argument Parser

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/Sappi)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/Sappi)

[![macOS](https://github.com/brightdigit/Sappi/workflows/macOS/badge.svg)](https://github.com/brightdigit/Sappi/actions?query=workflow%3AmacOS)
[![ubuntu](https://github.com/brightdigit/Sappi/workflows/ubuntu/badge.svg)](https://github.com/brightdigit/Sappi/actions?query=workflow%3Aubuntu)
[![Travis (.com)](https://img.shields.io/travis/com/brightdigit/Sappi?logo=travis&?label=travis-ci)](https://travis-ci.com/brightdigit/Sappi)
[![Bitrise](https://img.shields.io/bitrise/851943f7407ad016?logo=bitrise&?label=bitrise&token=jJAyoyJ-teNSI-9aDqJKSw)](https://app.bitrise.io/app/851943f7407ad016)
[![CircleCI](https://img.shields.io/circleci/build/github/brightdigit/Sappi?logo=circleci&?label=circle-ci&token=ee241fe22c5f6330a56357965bc13dbf2bcafc63)](https://app.circleci.com/pipelines/github/brightdigit/Sappi)

[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/Sappi)](https://codecov.io/gh/brightdigit/Sappi)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/Sappi)](https://www.codefactor.io/repository/github/brightdigit/Sappi)
[![codebeat badge](https://codebeat.co/badges/c47b7e58-867c-410b-80c5-57e10140ba0f)](https://codebeat.co/projects/github-com-brightdigit-Sappi-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/Sappi)](https://codeclimate.com/github/brightdigit/Sappi)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/Sappi?label=debt)](https://codeclimate.com/github/brightdigit/Sappi)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/Sappi)](https://codeclimate.com/github/brightdigit/Sappi)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

```bash
$ sappi -h
OVERVIEW: Prints and exports system information.

USAGE: sappi <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  print (default)         Prints system information out to the console.
  export                  Exports system information in any format.

  See 'sappi help <subcommand>' for detailed help.


$ sappi 
CPU Usage: 6%
Memory Usage: 95%
Usage of VM: 28% of 1000.24GB
Usage of Preboot: 28% of 1000.24GB
Usage of Media: 42% of 8001.35GB
Usage of Google Drive: 41% of 16.1GB
Usage of Update: 28% of 1000.24GB
Usage of Photos: 26% of 2000.18GB
Usage of Macintosh HD: 28% of 1000.24GB
Usage of Time Machine: 77% of 5000.28GB
Processes: 662
IPv6 address for en0: fe80::10cb:4190:8fe4:ed28
IPv4 address for en0: 192.168.1.76
IPv6 address for en0: 2600:1702:4050:7d30:4e9:86:816d:7e4d
IPv6 address for en0: 2600:1702:4050:7d30:88d3:849e:4a65:6aa3
IPv6 address for en0: 2600:1702:4050:7d30::51e
IPv6 address for en1: fe80::10c0:5193:8bf8:b99
IPv6 address for en1: 2600:1702:4050:7d30:cdb:5f0f:d5be:d86a
IPv6 address for en1: 2600:1702:4050:7d30:192e:3dc6:3d66:6acc
IPv4 address for en1: 192.168.1.82
IPv6 address for en1: 2600:1702:4050:7d30::72f
IPv6 address for en1: 2600:1702:4050:7d30:2193:e7f4:7fc4:97ef
```

# Introduction

This is a simple command line Swift Package for displaying system information as well as showing the power of the Swift Argument Parser:

* An example of optional **Arguments**
* Using enums in **Options**
* How to use **Flags** for verbose information

# Installation

The simplest way to install this application is via **mint**. Install **mint** via homebrew then run:

```bash
$ mint install brightdigit/Sappi
```

# Usage 

## Specifying Information via _Arguments_

Swift Argument Parser will use any non-flag or non-option and try to parse it into an `InfoType`. There are 5 accepted `InfoType` values:

* `cpu` CPU and Core Usage. Includes temperature information in verbose mode.
* `memory` Memory Usage.
* `disks` Disk Volume Usage.
* `processes`  Number of Active Processes.
* `network` Each connected network and address.


```bash
$ sappi cpu
CPU Usage: 10%
```

If no arguments are supplied then all `InfoType` values are assumed:

```bash
$ sappi
CPU Usage: 11%
Memory Usage: 37%
Usage of Media: 42% of 8001.35GB
Usage of Google Drive: 41% of 16.1GB
Usage of VM: 29% of 1000.24GB
Usage of Preboot: 29% of 1000.24GB
Usage of Update: 29% of 1000.24GB
Usage of Time Machine: 77% of 5000.28GB
Usage of Macintosh HD: 29% of 1000.24GB
Usage of Photos: 26% of 2000.18GB
Processes: 489
IPv6 address for en0: fe80::1ca8:35c4:4859:684e
IPv6 address for en0: 2600:1702:4050:7d30:4e9:86:816d:7e4d
IPv6 address for en0: 2600:1702:4050:7d30:64a9:183f:3960:86bc
IPv4 address for en0: 192.168.1.76
IPv6 address for en0: 2600:1702:4050:7d30::51e
IPv6 address for en1: fe80::81f:e405:7602:4003
IPv6 address for en1: 2600:1702:4050:7d30:cdb:5f0f:d5be:d86a
IPv6 address for en1: 2600:1702:4050:7d30:30dc:a334:3675:e05a
IPv4 address for en1: 192.168.1.82
IPv6 address for en1: 2600:1702:4050:7d30::72f
```

Multiple `InfoType` values are accepted:

```bash
$ sappi cpu disks
CPU Usage: 10%
Usage of Media: 42% of 8001.35GB
Usage of Time Machine: 77% of 5000.28GB
Usage of Photos: 26% of 2000.18GB
Usage of Update: 29% of 1000.24GB
Usage of Macintosh HD: 29% of 1000.24GB
Usage of Preboot: 29% of 1000.24GB
Usage of Google Drive: 41% of 16.1GB
Usage of VM: 29% of 1000.24GB
```

For more information, check out [the code documentation page on `InfoType` here.](Documentation/Reference/enums/InfoType.md)

## Formatting _Options_ For Values

**Sappi** gives you the ability to format cetain numerical values. 

Values such _CPU_, _Memory_, and _Disk_ allow for different ways to display usage or availability in relationship to the total by using the `--value-format=` option:

* `percent` - percent value
* `ratio` - units / total units
* `percentTotal` - percent / total units
* `default` - `percent` for _CPU_ and _Memory, `percentTotal` for _Disks_

```bash
$ sappi cpu memory disks --value-format=percent
CPU Usage: 20%
Memory Usage: 98%
Usage of Google Drive: 41%
Usage of Update: 15%
Usage of System: 15%
Usage of VM: 15%
Usage of Preboot: 15%
```

or

```bash
$ sappi cpu memory disks --value-format=ratio  
CPU Usage: 2416633 idle, 3053548 total
Memory Usage: 43 free, 6504 total
Usage of Update: 1619969011712 available, 1920140099584 total
Usage of Preboot: 1619969011712 available, 1920140099584 total
Usage of VM: 1619969011712 available, 1920140099584 total
Usage of Google Drive: 9482440704 available, 16106127360 total
Usage of System: 1619969011712 available, 1920140099584 total
```

For more information on the different value formats, check out [the documentation page on `RatioFormat` here.](Documentation/Reference/enums/RatioFormat.md)

## Getting CPU Temperature

__Sappi__ also has the ability to get various temperature available for your hardware. First you'll need to enable the `--verbose` option to get this information:

```bash
$ sappi cpu --verbose
CPU Usage: 20%
CPU 1 Usage: 31%
CPU 2 Usage: 13%
CPU 3 Usage: 26%
CPU 4 Usage: 11%
CPU Die Temperature: 64.0°C
Core 1 Temperature: 64.0°C
```

__Sappi__ also gives you the option to format the temperature in various scales:

* `celsuis` Celsuis Scale _default_
* `fahrenheit` Fahrenheit Scale
* `rankine` Rankine Scale
* `delisle` Delisle Scale
* `newton` Newton Scale
* `réaumur` Réaumur Scale
* `rømer` Rømer Scale

So for instance if you want your temperatures in Kelvin, simply use:

```bash
$ sappi cpu --verbose --temperature-unit=kelvin
CPU Usage: 20%
CPU 1 Usage: 31%
CPU 2 Usage: 13%
CPU 3 Usage: 26%
CPU 4 Usage: 11%
CPU Die Temperature: 324.15°K
Core 1 Temperature: 331.15°K
```

For more information, check out [the documentation page for `TemperatureUnit` here.](Documentation/Reference/enums/TemperatureUnit.md)

## Exporting Your Data

Lastly, __Sappi__ supports exporting data in various formats via the `exporting` subcommand. You've already seen the default subcommand `print` which only supports the `text` format.

```bash
$ sappi cpu disks
CPU Usage: 10%
Usage of Media: 42% of 8001.35GB
Usage of Time Machine: 77% of 5000.28GB
Usage of Photos: 26% of 2000.18GB
Usage of Update: 29% of 1000.24GB
Usage of Macintosh HD: 29% of 1000.24GB
Usage of Preboot: 29% of 1000.24GB
Usage of Google Drive: 41% of 16.1GB
Usage of VM: 29% of 1000.24GB
$ sappi print cpu disks
CPU Usage: 10%
Usage of Media: 42% of 8001.35GB
Usage of Time Machine: 77% of 5000.28GB
Usage of Photos: 26% of 2000.18GB
Usage of Update: 29% of 1000.24GB
Usage of Macintosh HD: 29% of 1000.24GB
Usage of Preboot: 29% of 1000.24GB
Usage of Google Drive: 41% of 16.1GB
Usage of VM: 29% of 1000.24GB
$ sappi export cpu disks --export-format=text
CPU Usage: 10%
Usage of Media: 42% of 8001.35GB
Usage of Time Machine: 77% of 5000.28GB
Usage of Photos: 26% of 2000.18GB
Usage of Update: 29% of 1000.24GB
Usage of Macintosh HD: 29% of 1000.24GB
Usage of Preboot: 29% of 1000.24GB
Usage of Google Drive: 41% of 16.1GB
Usage of VM: 29% of 1000.24GB
```

To export in various formats, use the subcommand `export`. Then use the `--format=` to specify a different format other than `text`:

* `text` - Standard text format _default_
* `json` - JSON format (ignores  `--value-format` and `--verbose`)
* `csv` - Comma-Separated Values 

For instance, to export all the CPU values including temperature (in Fahrenheit) in csv format:

```bash
$ sappi export --format=csv cpu --verbose --temperature-unit=fahrenheit
CPU,Usage,2005257,2138565
CPU,CPU 1,1636746,2138725
CPU,CPU 2,2117266,2138553
CPU,CPU 3,1772240,2138579
CPU,CPU 4,2119185,2138551
CPU,CPU 5,1847133,2138575
CPU,CPU 6,2119695,2138548
CPU,CPU 7,1898309,2138571
CPU,CPU 8,2119747,2138546
CPU,CPU 9,1941927,2138567
CPU,CPU 10,2119781,2138544
CPU,CPU 11,1990327,2138564
CPU,CPU 12,2120116,2138541
CPU,CPU 13,2008236,2138560
CPU,CPU 14,2120426,2138539
CPU,CPU 15,2032377,2138556
CPU,CPU 16,2120604,2138535
CPU,Die Temperature °F,,123.8
CPU,Core 1 Temperature °F,,123.8
CPU,Core 2 Temperature °F,,123.8
CPU,Core 3 Temperature °F,,122.0
CPU,Core 4 Temperature °F,,123.8
```

To export the data in JSON format use:

```bash
sappi export --format=json                     
{
  "cpu" : {
    "cores" : [
      {
        "idle" : 1646402,
        "sum" : 2151846
      },...
    ],
    "cpu" : {
      "idle" : 2017769,
      "sum" : 2151686
    },
    "temperatures" : [
      {
        "key" : "TC0P",
        "value" : 51
      },...
    ]
  },
  "memory" : {
    "free" : 92161,
    "total" : 131066
  },
  "networks" : [
    {
      "address" : "192.168.1.76",
      "family" : 0,
      "name" : "en0"
    },...
  ],
  "processes" : 561,
  "volumes" : [
    {
      "available" : 694472245248,
      "name" : "Macintosh HD",
      "total" : 1000240963584
    },...
  ]

```

For more information, check out [the documentation page for `ExportFormat` here.](Documentation/Reference/enums/ExportFormat.md)

# Support 

If you have any questions or issues with the application, feel free to post [an issue here.](issues) 

# License 

This code is distributed under the MIT license. See the [LICENSE](LICENSE) file for more info.
