
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

## Changing Your Salutation _Option_

You can choose from a variety of options for your salutation. Currently, **Sappi** supports:

* `hey` = "Hey" [**default**]
* `hello` = "Hello"
* `ciao` = "Ciao"
* `buongiorno` = "Buongiorno"
* `cheers` = "Cheers"
* `greetings` = "Greetings"
* `hi` = "Hi"
* `howdy` = "Howdy"
* `welcome` = "Welcome"
* `bonjour` = "Bonjour"
* `sup` = "Sup 🤜" (i.e. _Sup_ with a fist pump 🤜)
* `heeey` = "Heeey 😎" (i.e. _Heeey_ with sunglass emoji 😎)

To change the salutation from the default _Hey_ simply pass the option `--salutation=`:

```bash
$ hey World --salutation=hello
Hello World!
```

or

```bash
$ hey Dude --salutation=heeey
Heeey 😎 Dude!
```

If you supply no salutation, you will get the _default_ salutation, _Hey_:

```bash
$ hey World
Hey World!
```

For more information on salutions, please refer to [the code documentation page here](Documentation/Reference/Salutation.md).

## _Flags_ for More Verbose Greetings

If you wish _Sappi_ to offer a more verbose greeeting, simply use the flag `--verbose`. With the `--verbose` flag, you will receive an extended `How's your day?`:

```bash
$ hey --verbose
Hey Sap, How's Your Day?
```

By combining all these components, you can build something like this:

```bash
$ hey Maximiliano --salutation=buongiorno --verbose
Buongiorno Maximiliano, How's Your Day?
```

# Support 

If you have any questions or issues with the application, feel free to post [an issue here.](issues) 

# License 

This code is distributed under the MIT license. See the [LICENSE](LICENSE) file for more info.
