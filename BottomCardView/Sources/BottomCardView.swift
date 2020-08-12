//
//  ScrolledBottomController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import pop

class BottomCardView: UIView {
    var direction: Direction!
    var previousPoint = CGPoint(x: 0, y: 0)
    var currentPointIndex = 0
    var pointsRaw: [CGFloat] = []

    var points: [TargetPoint] {
        return pointsRaw.sorted(by: <)
    }

    var cornerRadius: CGFloat = 15 {
        didSet {
            createMask(radius: cornerRadius)
        }
    }

    var height: CGFloat {
        get {
            return self.frame.height
        }
        set {
            let minY = UIScreen.main.bounds.height - newValue
            self.frame.origin.y = minY
            self.frame.size.height = newValue
        }
    }

    var minPoint: CGFloat {
        get {
            return min
        }
        set {
            if newValue > min, height <= min {
                height = newValue
            }
            min = newValue
        }
    }

    private var min: CGFloat = 0 {
        didSet {
            if min < 0 {
                pointsRaw[0] = 0
            } else {
                pointsRaw[0] = min
            }
        }
    }

    weak var delegate: BottomCardViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func changeSize(difference: CGFloat) {
        removeAllAnimations()
        direction = difference > 0 ? .up : .down
        if height >= points.last! {
            height += difference / 5
        } else {
            height += difference
        }
    }

    func removeAllAnimations() {
        pop_removeAllAnimations()
    }

    func getCurrentPoint() {
        if direction == .up {
            guard currentPointIndex != points.count - 1 else {return}
            let nextPointHeight = points[currentPointIndex + 1]
            if height >= nextPointHeight {
                currentPointIndex += 1
            }
        } else if currentPointIndex != 0 {
            let nextPointHeight = points[currentPointIndex - 1]
            if height <= nextPointHeight {
                currentPointIndex -= 1
            }
        }
    }

    func moveToPointWithAnimation() {
        var nearestPoint = points[currentPointIndex]
        var minValue: CGFloat = .infinity
        for point in points {
            let difference = abs(point - height)
            if difference < minValue {
                minValue = difference
                nearestPoint = point
            }
        }
        animation(to: nearestPoint)
    }

    // toDO: need to change animation
    func animation(to: CGFloat) {
        let spring = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        let minY: CGFloat = UIScreen.main.bounds.height - to
        spring?.toValue = CGRect(x: 0, y: minY, width: frame.size.width, height: to)
        spring?.springBounciness = 20
        spring?.springSpeed = 30
        pop_add(spring, forKey: "move")
    }

    func getNextPoint() {
        let currentPointHeight = points[currentPointIndex]
        var nextPointIndex: Int = currentPointIndex
        if height > currentPointHeight {
            if currentPointIndex >= points.count - 1 {
                nextPointIndex = points.count - 1
            } else {
                nextPointIndex = currentPointIndex + 1
            }
        }
        if height < currentPointHeight {
            if currentPointIndex <= 0 {
                nextPointIndex = 0
            } else {
                nextPointIndex = currentPointIndex - 1
            }
        }
        getProgressValue(nextPointIndex: nextPointIndex)
    }

    func getProgressValue(nextPointIndex: Int) {
        let currentPointHeight = points[currentPointIndex]
        let nextPointHeight = points[nextPointIndex]
        let currentHeight = height - currentPointHeight
        let length = (nextPointHeight - currentPointHeight)
        var valueToNextPoint: CGFloat = 0
        if height == points[currentPointIndex] {
            valueToNextPoint = 0
        } else {
            valueToNextPoint = currentHeight / length
        }
        delegate?.valueToPointDidChange(from: currentPointIndex, to: nextPointIndex, progress: valueToNextPoint)
    }
}
