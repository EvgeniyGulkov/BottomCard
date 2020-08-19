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
    public var side: Side = .bottom

    var pointsRaw = Set<CGFloat>()
    var previousPoint = CGPoint(x: 0, y: 0)

    var maxHeight: CGFloat {
        return UIScreen.main.bounds.height - topInset - bottomInset
    }

    var topInset: CGFloat {
        return insets?.top ?? 0
    }

    var bottomInset: CGFloat {
        return insets?.bottom ?? 0
    }

    public var insets: UIEdgeInsets? {
        get {
            return safeInsets
        }
        set {
            if newValue != safeInsets {
                safeInsets = newValue
                if maxPoint != nil {
                    addPoint(value: .infinity)
                }
                moveToNearestPoint(animation: .basic(duration: 0.01))
            }
        }
    }

    private func optimize() {
        if let min = points.first, height < min {
            height = min
        }
    }

    private var safeInsets: UIEdgeInsets?

    public var points: [TargetPoint] {
        return pointsRaw.sorted(by: <)
    }

    var height: CGFloat {
        get {
            switch side {
            case .top:
                return self.frame.size.height
            case .bottom:
                return maxHeight - frame.minY + topInset
            }
        }
        set {
            if let min = points.first, newValue < min {
                return
            } else {
                updateHeight(value: newValue)
            }
        }
    }

    public var minPoint: CGFloat {
        get {
            return min
        }
        set {
            pointsRaw.remove(min)
            min = newValue
            if min < 0 {
                min = 0
            }
            pointsRaw.insert(min)
            optimize()
        }
    }

    var maxPoint: CGFloat?

    private var min: CGFloat = 0

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
        var difference = difference
        removeAllAnimations()
        direction = difference > 0 ? .up : .down
        if side == .top {
            difference *= -1
        }
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

    func moveToNearestPoint(animation: AnimationType = .spring) {
        var nearestPoint = points[currentPointIndex]
        var minValue: CGFloat = .infinity
        for point in points {
            let difference = abs(point - height)
            if difference < minValue {
                minValue = difference
                nearestPoint = point
            }
        }
        moveWithAnimation(point: nearestPoint, animationType: animation, completion: nil)
    }

    func moveWithAnimation(point: TargetPoint, animationType: AnimationType, completion: ((POPAnimation?, Bool) -> Void)? = nil) {
        switch animationType {
        case .spring:
            ViewAnimator.topSpringAnimation(view: self,
                                            to: point,
                                            bounces: bounces,
                                            speed: animationSpeed,
                                            completion)
        case .basic(let duration):
            ViewAnimator.topAnimation(view: self,
                                      to: point,
                                      duration: duration,
                                      completion)
        case .none:
            height = point
            completion?(nil, true)
        }
    }

    func getNextPoint() -> Int {
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
        return nextPointIndex
    }

    func getProgressValue(nextPointIndex: Int) -> CGFloat {
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
        let tempProgress = (progress * 100).rounded()
        progress = CGFloat(tempProgress / 100)
        if progress == .infinity || progress == -.infinity {
            progress = 0
        }
        return progress
    }

    private func updateHeight(value: CGFloat) {
        switch side {
        case .top:
            self.frame.origin.y = topInset
            self.frame.size.height = value
        case .bottom:
            self.frame.origin.y = maxHeight - value + topInset
            self.frame.size.height = value
        }
    }
}
