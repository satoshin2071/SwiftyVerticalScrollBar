# SwiftyVerticalScrollBar

A custom scrollbar for a UIScrollView or UIScrollView's subclasses. This is a re-write [WKVerticalScrollBar](https://github.com/litl/WKVerticalScrollBar) in Swift

[![CI Status](http://img.shields.io/travis/satoshin2071/SwiftyVerticalScrollBar.svg?style=flat)](https://travis-ci.org/satoshin2071/SwiftyVerticalScrollBar)
[![Version](https://img.shields.io/cocoapods/v/SwiftyVerticalScrollBar.svg?style=flat)](http://cocoapods.org/pods/SwiftyVerticalScrollBar)
[![License](https://img.shields.io/cocoapods/l/SwiftyVerticalScrollBar.svg?style=flat)](http://cocoapods.org/pods/SwiftyVerticalScrollBar)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyVerticalScrollBar.svg?style=flat)](http://cocoapods.org/pods/SwiftyVerticalScrollBar)

## Requirements

Swift 2.2

## Installation

SwiftyVerticalScrollBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
platform :ios, '8.0'
use_frameworks!

target 'TargetName' do
  pod 'SwiftyVerticalScrollBar'
end
```

CocoaPods 1.0.0 new [specification](https://guides.cocoapods.org/using/the-podfile.html). all your pod include should be specified target based

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

1 Please uncheck the checkbox of `underTopBars` if ViewController to use the UINavigationController

![](https://raw.githubusercontent.com/satoshin2071/SwiftyVerticalScrollBar/master/underTopBar.png)

2 initialize SwiftyVerticalScrollBar in viewDidLoad

```Swift
DemoViewController.swift

override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollBar = SwiftyVerticalScrollBar(frame: CGRectZero, targetScrollView: self.tableView)
        self.view.addSubview(self.scrollBar!)
}
```

3 set frame in viewDidLayoutSubviews

```Swift
DemoViewController.swift

override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.scrollBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
}

```

4 Build and Run!

![](https://raw.githubusercontent.com/satoshin2071/SwiftyVerticalScrollBar/master/ss.gif)


## License

SwiftyVerticalScrollBar is available under the MIT license. See the LICENSE file for more info.
