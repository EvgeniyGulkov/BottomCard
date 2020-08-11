//
//  BottomCardView+GestureDelegate.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 11.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension BottomCardView: UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = gestureRecognizer.view as? UIScrollView else {return false}
        previousPoint = gestureRecognizer.location(in: superview!)
        limit = scrollView.contentSize.height - scrollView.visibleSize.height
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if otherGestureRecognizer == containerRecognizer {
            return false
        }
        return true
    }
}
