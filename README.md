# HJCornerRadius

![](https://img.shields.io/badge/build-passing-brightgreen.svg)
![](https://img.shields.io/badge/pod-v0.4.1-blue.svg)
![](https://img.shields.io/badge/language-objc-5787e5.svg)
![](https://img.shields.io/badge/license-MIT-brightgreen.svg)  

This library provides a category for UIImageView with support for cornerRadius automatically

一行代码搞定图片圆角

For more details please click [here](http://www.olinone.com/?p=484)

##How To Use

```
imageview.aliCornerRadius = 5.0f;
```

##Note

make sure

```
imageview.layer.masksToBounds = NO
```

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries in your projects. See the [Get Started](http://cocoapods.org/#get_started) section for more details.

## Podfile

```
pod 'HJCornerRadius', :git => "https://github.com/panghaijiao/HJCornerRadius.git"
```


##License:  

HJCornerRadius is released under the MIT license. See LICENSE for details.
