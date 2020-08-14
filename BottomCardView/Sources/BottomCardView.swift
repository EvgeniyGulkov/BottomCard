//
//  ScrolledBottomController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import pop

public class BottomCardView: UIView {
    public var bounces: CGFloat = 5
    public var animationSpeed: CGFloat = 10
    public var currentPointIndex = 0
    public var direction: Direction!

    var pointsRaw: [CGFloat] = []
    var previousPoint = CGPoint(x: 0, y: 0)

    var viewInsets: UIEdgeInsets?

    var width: CGFloat = 0 {
        didSet {
            createMask(radius: cornerRadius)
        }
    }

    public var points: [TargetPoint] {
        return pointsRaw.sorted(by: <)
    }

    public var cornerRadius: CGFloat = 15 {
        didSet {
            createMask(radius: cornerRadius)
        }
    }

    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            let maxHeight = UIScreen.main.bounds.height - (viewInsets?.bottom ?? 0)
            let minY = UIScreen.main.bounds.height - newValue - (viewInsets?.bottom ?? 0)
            if minY <= 0 {
                self.frame.origin.y = 0
                if height < maxHeight {
                    self.frame.size.height = maxHeight
                }
                return
            }
            if newValue <= minPoint {
                self.frame.origin.y = maxHeight - minPoint
                self.frame.size.height = minPoint
                return
            }
            self.frame.origin.y = minY
            self.frame.size.height = newValue
        }
    }

    public var minPoint: CGFloat {
        get {
            return min
        }
        set {
            min = newValue
            if height < newValue {
                height = newValue
            }
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

    public weak var delegate: BottomCardViewDelegate?

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
        ViewAnimator.topSpringAnimation(view: self,
                                        to: nearestPoint,
                                        bottomInset: viewInsets?.bottom ?? 0,
                                        bounces: bounces,
                                        speed: animationSpeed) { [unowned self] animation in self.delegate?.bottomCardView(springAnimationComplete: animation, inPoint: self.currentPointIndex, onHeight: self.height)}
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
        var progress: CGFloat = 0
        if height == points[currentPointIndex] {
            progress = 0
        } else {
            progress = currentHeight / length
        }
        delegate?.bottomCardView(progressDidChangeFromPoint: currentPointIndex,
                                 toPoint: nextPointIndex,
                                 withProgress: progress)
    }
}
