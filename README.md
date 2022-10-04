# WebPortal
> WebPortal is a thin layer on top of [ionic-portals](https://github.com/ionic-team/ionic-portals-ios). It enables micro web app suppport in the iOS app

<p align="center">
  <img src="https://img.shields.io/badge/spm-Compatible-orange?style=flat-square" alt="SPM Compatible"/>
  <img src="https://img.shields.io/badge/platform-iOS%2013%2B-lightgrey?style=flat-square" alt="Supports iOS 13 and up" />
</p>

## Table of Contents
* [Introduction](#introduction)
* [External Dependencies](#external-dependencies)
* [Setup](#setup)
* [Usage](#usage)
* [Project Status](#project-status)


## Introduction
- WebPortal allows easy setup of [ionic-portals](https://github.com/ionic-team/ionic-portals-ios) in the EGYM iOS apps and provides well-defined topics for publishing and subscribing 
- This project can be used as a swift package and allows to share ionic-portal setup code among EGYM iOS apps

## External Dependencies
- [ionic-portals](https://github.com/ionic-team/ionic-portals-ios) - from v0.6.4


## Setup
- swift package(recommended)
- git submodules

## Usage
The web portal communicate with micro web app via Publisher Subscriber design pattern.<br>
Publishing topics:

```
public enum PublishTopic: String, Codable {
    case authToken
    case error
    case exerciserInfo
	  case trainerInfo
    case openWebView
}
```

Subscribing topics:

```
public enum CallbackType: String, Codable {
    case authToken
    case exerciserInfo
    case trainerInfo
    case dismiss
    case openFeature
    case openUrlExternally
    case openWebView
}
```


## Project Status
Project is: _in progress_ 

