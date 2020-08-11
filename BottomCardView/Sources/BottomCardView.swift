//
//  ScrolledBottomController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

class BottomCardView: UIView {
    var direction: Direction!
    var containerViewHeight: NSLayoutConstraint!
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
            return containerViewHeight.constant
        }
        set {
            if newValue >= points.last! {
                containerViewHeight.constant = points.last!
            } else {
                containerViewHeight.constant = newValue
            }
            getCurrentPoint()
            getNextPoint()
            delegate?.heightDidChange(height: newValue)
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
        direction = difference > 0 ? .up : .down
        if height >= minPoint {
            height += difference
            return
        }
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
        UIView.animate(withDuration: 0.2, animations: {
            self.height = to
            self.superview!.layoutIfNeeded()
        })
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
