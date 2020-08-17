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
        didSet {
            if height < bottomInset {
                changeHeight(value: bottomInset, animation: .none)
            }
        }
    }

    public var points: [TargetPoint] {
        return pointsRaw.sorted(by: <)
    }

    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            updateHeight(value: newValue)
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

    var maxPoint: CGFloat?

    private var min: CGFloat = 0 {
        didSet {
            if min < 0 {
                pointsRaw.insert(0)
            } else {
                pointsRaw.insert(min)
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

    private func updateHeight(value: CGFloat) {
        let minY = maxHeight - value + topInset
        if minY < topInset {
            self.frame.origin.y = topInset
            if height < maxHeight {
                self.frame.size.height = maxHeight
            }
            return
        }
        if value <= minPoint {
            self.frame.origin.y = maxHeight - minPoint + topInset
            self.frame.size.height = minPoint
            return
        }
        self.frame.origin.y = minY
        self.frame.size.height = value
    }
}
