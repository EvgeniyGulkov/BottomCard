//
//  ViewAnimator.swift
//  BottomCardView
//
//  Created by Gulkov on 13.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import pop

class ViewAnimator {
    static func topSpringAnimation(view: UIView, to: CGFloat, bottomInset: CGFloat, bounces: CGFloat, speed: CGFloat) {
        let spring = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        var minY: CGFloat = UIScreen.main.bounds.height - to - bottomInset
        var height = to
        if minY <= 0 {
            minY = 0
            height = UIScreen.main.bounds.height - bottomInset
        }
        spring?.toValue = CGRect(x: view.frame.minX, y: minY, width: view.frame.size.width, height: height)
        spring?.springBounciness = bounces
        spring?.springSpeed = speed
        view.pop_add(spring, forKey: "kPOPViewFrame")
    }
}
