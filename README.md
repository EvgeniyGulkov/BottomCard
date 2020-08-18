# BottomCardView
#### BottomCardView is a view based on UIView, written in Swift 
#### and using [POP](https://github.com/facebookarchive/pop) for animations

![alt-text](https://github.com/EvgeniyGulkov/BottomCardView/blob/master/BottomCardView/Media.xcassets/screen_image.dataset/ezgif-6-5c005dac91f7.gif)
## Requirements
BottomCardView is written in Swift 5. Compatible with iOS 11.0+.

## Installation

### Cocoapods
```ruby
pod 'BottomCardView'
```

## Usage
### Setup

You can use this view as simple UIView using interface builder or add it programmatically

Usage example:

```swift
import BottomCardView

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

#### Tracking height

You can track the height and position using the dedicated delegate methods:

```swift
func bottomCardView(progressDidChangeFromPoint index: Int, toPoint nextIndex: Int, withProgress progress: CGFloat)

func bottomCardView(viewHeightDidChange height: CGFloat)
```

## Author

[@EvgeniyGulkov](https://www.linkedin.com/in/evgeniy-gulkov-69b29216a), ewgeniy2004@list.ru

## License

BottomCardView is available under the MIT license. See the LICENSE file for more info.
