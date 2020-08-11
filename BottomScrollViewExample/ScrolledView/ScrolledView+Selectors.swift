//
//  ScrolledView+Selectors.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension ScrolledView {

    @objc
    func scrollViewScrolled(_ sender: UIPanGestureRecognizer) {
        guard let scrollView = sender.view as? UIScrollView else {return}
        if sender.state == .changed {
            limit = scrollView.contentSize.height - scrollView.visibleSize.height
            let point = scrollView.panGestureRecognizer.location(in: superview!)
            let difference = previousPoint.y - point.y
            if (round(scrollView.contentOffset.y) >= round(limit) && difference > 0) ||
                (round(scrollView.contentOffset.y) <= 0 && difference < 0)
                {
                changeSize(difference: difference)
            }
            previousPoint = scrollView.panGestureRecognizer.location(in: superview!)
        } else if sender.state == .ended {
            moveToPointWithAnimation()
        }
    }

    func viewTouched(state: TouchState, point: CGPoint) {
        if state == .began {
            previousPoint = point
        } else if state == .moved {
            let point = point
            let difference = previousPoint.y - point.y
            changeSize(difference: difference)
            previousPoint = point
        } else if state == .ended {
            moveToPointWithAnimation()
        }
    }

}
