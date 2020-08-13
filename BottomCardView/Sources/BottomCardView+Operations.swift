//
//  BottomCardView+Operations.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

public typealias TargetPoint = CGFloat

extension BottomCardView {
    public func addScroll( for scrollView: UIScrollView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(scrollViewScrolled))
        gesture.delegate = self
        scrollView.addGestureRecognizer(gesture)
    }

    public func addPoint(value: TargetPoint) {
        let maxHeight = UIScreen.main.bounds.height - (viewInsets?.bottom ?? 0)
        if value > maxHeight {
            pointsRaw.append(maxHeight)
        } else {
            pointsRaw.append(value)
        }
    }

    public func moveToPoint(index: Int) {
        height = points[index]
    }

    public func setViewHeight(value: CGFloat) {
        height = value
    }
}
