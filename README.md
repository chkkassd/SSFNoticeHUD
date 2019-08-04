# SSFNoticeHUD

[![Version](https://img.shields.io/cocoapods/v/SSFNoticeHUD.svg?style=flat)](https://cocoapods.org/pods/SSFNoticeHUD)
[![License](https://img.shields.io/cocoapods/l/SSFNoticeHUD.svg?style=flat)](https://cocoapods.org/pods/SSFNoticeHUD)
[![Platform](https://img.shields.io/cocoapods/p/SSFNoticeHUD.svg?style=flat)](https://cocoapods.org/pods/SSFNoticeHUD)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
* iOS 9.3
* Swift 5.0

## Installation

SSFNoticeHUD is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SSFNoticeHUD'
```

## Usage
![展示图](https://github.com/chkkassd/SSFNoticeHUD/blob/master/SSFNoticeHUDShow.gif)
```swift
///标准模式成功Toast（图片+文案）
public func SSFNoticeSuccess(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD 
///标准模式失败Toast（图片+文案）
public func SSFNoticeError(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD 
///标准模式提示信息Toast（图片+文案）
public func SSFNoticeInfo(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD
///只有文案Toast
public func SSFNoticeForOnlyText(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD
///标准模式加载Toast（菊花+文案）
public func SSFNoticeForStandardLoading(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD 
///简易模式加载Toast（菊花）
public func SSFNoticeForOnlyLoading(autoClear: Bool, delay: Double) -> SSFNoticeHUD 
///状态栏成功Toast（文案+绿背景）
public func SSFNoticeTopSuccess(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD 
///状态栏失败Toast（文案+红背景）
public func SSFNoticeTopError(text: String, autoClear: Bool, delay: Double) -> SSFNoticeHUD 
///标准模式自定义Toast（图片+文案）
public func SSFNoticeForStandard(customImage: UIImage, text: String, autoClear: Bool, delay: Double) ->SSFNoticeHUD 

//if you don't use auto clear, you can clear all hud manualy by this methdos
public func SSFClearAll()
```
you can call all above methods just by 'self'
```swift
self.SSFNoticeSuccess(text: "Success", autoClear: true, delay: 2)
self.SSFNoticeTopSuccess(text: "Success", autoClear: true, delay: 2)
```
## Author

Peter Shi, peter1990lynn@gmail.com

## License

SSFNoticeHUD is available under the MIT license. See the LICENSE file for more info.
