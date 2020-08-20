# BottomCard
#### BottomCard is a view based on UIView, written in Swift 
#### and using [POP](https://github.com/facebookarchive/pop) for animations

![alt-text](https://github.com/EvgeniyGulkov/BottomCard/blob/master/BottomCardExample/Media.xcassets/screen_image.dataset/ezgif-4-73d9a315e712.gif)
![alt-text](https://github.com/EvgeniyGulkov/BottomCard/blob/master/BottomCardExample/Media.xcassets/test-bottom.dataset/ezgif-4-7608f111ba9e.gif)

<p align="center">
  <a href="https://developer.apple.com/"><img alt="Platform" src="https://img.shields.io/badge/platform-iOS-green.svg"/></a>
  <a href="https://developer.apple.com/swift"><img alt="Swift5" src="https://img.shields.io/badge/language-Swift%205.0-orange.svg"/></a>
  <a href="https://cocoapods.org/pods/bottomcard"><img alt="CocoaPods" src="https://img.shields.io/cocoapods/v/BottomCard"/></a>
  <a href="https://github.com/Carthage/Carthage"><img alt="Carthage" src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"/></a>
  <a href="https://github.com/EvgeniyGulkov/BottomCard/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/cocoapods/l/BottomCard"/></a>
</p>

## Requirements
BottomCard is written in Swift 5. Compatible with iOS 11.0+.

## Installation

### Cocoapods
```ruby
pod 'BottomCard'
```

### Carthage
```ruby
github "EvgeniyGulkov/BottomCard"
```


## Usage
### Setup

Use this view as simple UIView using interface builder or add it programmatically.
You can add as more points as you want.
The highest point value is the height limit for your bottomCardView.

Usage example:

```swift
import BottomCard

class ViewController: UIViewController, BottomCardViewDelegate {

    @IBOutlet weak var bottomCardView: BottomCardView!
    @IBOutlet weak var tableViewInBottom: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomCard()
    }

    func setupBottomCard() {

        /// add point (value from bottom)
        bottomCardView.addPoint(value: 400)
        
        /// if you want to use top of your screen or top safe area inset as top point,
        /// you should add point greater or equal your screen height. for example .infinity
        bottomCardView.addPoint(value: .infinity)

        /// set minimum point from bottom
        bottomCardView.minPoint = 30

        /// set delegate
        bottomCardView.delegate = self

        /// if you want to scroll BottomCardView when scrollView inside
        /// is scrolled to end, you should add it with following method
        bottomCardView.addScroll(for: tableViewInBottom)
    }
```
You can change height programmatically:

```swift
bottomCardView.changeHeight(value: 100, animation: .basic(duration: 0.2)) { animation, complete in

}

/// change by point index
bottomCardView.moveToPoint(index: 1, animation: .spring) { animation, complete in

}
```
Also you can choose type of you animation:
- none (without animation)
- spring (spring animation with default parameters)
- basic (animation w/o spring, but you can change duration time)

For change default properties for spring animation:

```swift
bottomCardView.bounces = 4
bottomCardView.animationSpeed = 20
```

Set safe area insets:
```swift
override func viewDidLayoutSubviews() {
    bottomCardView.insets = view.safeAreaInsets
}
```

Use from top:

![alt-text](https://github.com/EvgeniyGulkov/BottomCard/blob/master/BottomCardExample/Media.xcassets/test-top.dataset/ezgif-4-3cd1f7fa5b36.gif)

```swift
bottomCardView.side = .top
```

#### Tracking height

You can track the height and position using the dedicated delegate methods:

```swift
func bottomCardView(progressDidChangeFromPoint index: Int, toPoint nextIndex: Int, withProgress progress: CGFloat)

func bottomCardView(viewHeightDidChange height: CGFloat)
```

#### Tracking animation

Also you can track the animation using the delegate methods:
```swift
func bottomCardView(popAnimationDidStart animation: POPAnimation)

func bottomCardView(popAnimationDidApply animation: POPAnimation)

func bottomCardView(popAnimationDidReach animation: POPAnimation)

func bottomCardView(popAnimationDidStop animation: POPAnimation, finished: Bool)
```

## Author

[@EvgeniyGulkov](https://www.linkedin.com/in/evgeniy-gulkov-69b29216a), ewgeniy2004@list.ru

## License

BottomCard is available under the MIT license. See the LICENSE file for more info.
