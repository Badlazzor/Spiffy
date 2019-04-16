# Spiffy

[![Build Status](https://api.travis-ci.org/Badlazzor/Spiffy.svg?branch=master)](https://travis-ci.org/Badlazzor/Spiffy)
[![CocoaPods](https://img.shields.io/cocoapods/v/Spiffy.svg)](https://cocoapods.org/pods/Spiffy)
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

Spiffy is a lightweight styling library for iOS apps written in Swift. It's main goal is to help define easy-to-apply styles, and NOT to create an all-knowing super wrapper.

```swift
// Swift

import Spiffy
import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var label: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        
        button.styled(by: Styles.Showcase.Button.base)
        label.styled(by: Styles.Showcase.Label.base)
    }
}

extension Styles {
    fileprivate enum Showcase {
        enum Label {
            static let base = Styles.Label.Style(
                .alignment(.right),
                .color(.blue)
            )
        }
        
        enum Button {
            static let base: [Styling] = [
                Styles.View.Predefined.autolayouted,
                Styles.Button.Style(
                    .titleColor(with: .black, for: .normal),
                    .backgroundColor(with: .white, for: .normal),
                    .titleColor(with: .red, for: .highlighted),
                    .backgroundColor(with: .gray, for: .highlighted)
                )
            ]
        }
    }
}
```

## Requirements

- XCode 10.0
- Swift 4.2

## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

**Tested with `pod --version`: `1.6.1`**

```ruby
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'Spiffy',    '~> 0.0.1'
end
```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```bash
$ pod install
```