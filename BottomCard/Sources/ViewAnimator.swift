//
//  ViewAnimator.swift
//  BottomCardView
//
//  Created by Gulkov on 13.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import pop

public class ViewAnimator {
    private static let springAnimationKey = "kPOPViewFrameSpring"
    private static let basicAnimationKey = "kPOPViewFrameBasic"

    static func topSpringAnimation(view: BottomCardView, to: CGFloat, bounces: CGFloat, speed: CGFloat, _ completion: ((POPAnimation?, Bool) -> Void)?) {
        let spring = POPSpringAnimation(propertyNamed: kPOPViewFrame)
        spring?.delegate = view
        var minY: CGFloat = view.maxHeight - to + view.topInset
        var height = to
        if minY <= view.topInset {
            minY = view.topInset
            height = view.maxHeight
        }
        if view.side == .top {
            minY = view.topInset
            height = to
        }
        spring?.toValue = CGRect(x: view.frame.minX, y: minY, width: view.frame.size.width, height: height)
        spring?.springBounciness = bounces
        spring?.springSpeed = speed
        spring?.completionBlock = {
            view.height = to
            completion?($0, $1)
        }
        view.pop_add(spring, forKey: springAnimationKey)
    }

    static func topAnimation(view: BottomCardView, to: CGFloat, duration: Double, _ completion: ((POPAnimation?, Bool) -> Void)?) {
        let basic = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        basic?.delegate = view
        var minY: CGFloat = view.maxHeight - to + view.topInset
        var height = to
        if minY <= view.topInset {
            minY = view.topInset
            height = view.maxHeight
        }
        if view.side == .top {
            minY = view.topInset
            height = to
        }
        basic?.toValue = CGRect(x: view.frame.minX, y: minY, width: view.frame.size.width, height: height)
        basic?.duration = duration
        basic?.completionBlock = {
            view.height = to
            completion?($0, $1)
        }
        view.pop_add(basic, forKey: basicAnimationKey)
    }
}
