//
//  ScrolledView+Operations.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

typealias TargetPoint = CGFloat

extension ScrolledView {
    public func addScroll( for scrollView: UIScrollView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(scrollViewScrolled))
        gesture.delegate = self
        scrollView.addGestureRecognizer(gesture)
    }

    public func addPoint(value: TargetPoint) {
        pointsRaw.append(value)
    }
}
