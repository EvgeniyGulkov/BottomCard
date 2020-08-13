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
        guard let superView = superview else {return false}
        previousPoint = gestureRecognizer.location(in: superView)
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
