//
//  BottomCardView+Selectors.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension BottomCardView {

    @objc
    func scrollViewScrolled(_ sender: UIPanGestureRecognizer) {
        guard let scrollView = sender.view as? UIScrollView, let superView = superview else {return}
        if sender.state == .began {
            previousPoint = sender.location(in: superView)
        } else if sender.state == .changed {
            let visibleHeight = scrollView.frame.size.height - (scrollView.contentInset.top + scrollView.adjustedContentInset.top) - (scrollView.contentInset.bottom + scrollView.adjustedContentInset.bottom)
            let limit = scrollView.contentSize.height - visibleHeight
            let point = scrollView.panGestureRecognizer.location(in: superView)
            let difference = previousPoint.y - point.y
            if (round(scrollView.contentOffset.y) >= round(limit) && difference > 0) ||
                (round(scrollView.contentOffset.y) <= 0 && difference < 0)
                {
                changeSize(difference: difference)
            }
            previousPoint = scrollView.panGestureRecognizer.location(in: superView)
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
