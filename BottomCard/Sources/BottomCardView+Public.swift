//
//  BottomCardView+Operations.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import pop

public typealias TargetPoint = CGFloat

extension BottomCardView {
    public func addScroll( for scrollView: UIScrollView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(scrollViewScrolled))
        gesture.delegate = self
        scrollView.addGestureRecognizer(gesture)
    }

    public func addPoint(value: TargetPoint) {
        if value >= maxHeight {
            addMaxPoint(value: value)
        } else {
            pointsRaw.insert(value)
        }
    }

    private func addMaxPoint(value: CGFloat) {
        if let max = maxPoint {
            pointsRaw.remove(max)
        }
        maxPoint = maxHeight
        pointsRaw.insert(maxHeight)
    }

    public func moveToPoint(index: Int,
                            animation: AnimationType,
                            _ completion: ((POPAnimation?, Bool) -> Void)? = nil) {
        let point = points[index]
        changeHeight(value: point, animation: animation, completion)
    }

    public func changeHeight(value: CGFloat,
                             animation: AnimationType,
                             _ completion: ((POPAnimation?, Bool) -> Void)? = nil) {
        moveWithAnimation(point: value, animationType: animation, completion: completion)
    }
}
