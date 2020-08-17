# BottomCardView
### BottomCardView is a view based on UIView, written in Swift 
and using [POP](https://github.com/facebookarchive/pop) from animations

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

You can use this view as simple UIView using IB or add it programmatically

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
        
        /// 
        bottomCardView.addPoint(value: .infinity)

        /// set minimum point from bottom
        bottomCardView.minPoint = 30

        /// set delegate
        bottomCardView.delegate = self
        
        /// enable or disable safeAreaInsets
        bottomCardView.insetsFromSafeAreaEnabled = true

        /// if you want to scroll BottomCardView when scrollView inside
        is scrolled to end, you should add it with following method
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
- none (withou animation)
- spring (spring animation with default parameters)
- basic (animation w/o sprion, but you can change duration time)

For change default properties for spring animation:

```swift
bottomCardView.bounces = 4
bottomCardView.animationSpeed = 20
```

## Author

[@EvgeniyGulkov](https://www.linkedin.com/in/evgeniy-gulkov-69b29216a), ewgeniy2004@list.ru

## License

BottomCardView is available under the MIT license. See the LICENSE file for more info.
