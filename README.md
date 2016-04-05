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
pod "SwiftyVerticalScrollBar"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

**Example**

![](https://raw.githubusercontent.com/satoshin2071/SwiftyVerticalScrollBar/master/ss.gif)

```Swift
DemoViewController.swift

override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollBar = SwiftyVerticalScrollBar(frame: CGRectZero, targetScrollView: self.tableView)
        self.view.addSubview(self.scrollBar!)
}

override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.scrollBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
}

```

## License

SwiftyVerticalScrollBar is available under the MIT license. See the LICENSE file for more info.
