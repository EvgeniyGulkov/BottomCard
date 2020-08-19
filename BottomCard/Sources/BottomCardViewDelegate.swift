//
//  BottomCardViewDelegate.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import pop

public protocol BottomCardViewDelegate: class {
    func bottomCardView(progressDidChangeFromPoint index: Int,
                        toPoint nextIndex: Int,
                        withProgress progress: CGFloat)

    func bottomCardView(viewHeightDidChange height: CGFloat)

    func bottomCardView(popAnimationDidStart animation: POPAnimation)

    func bottomCardView(popAnimationDidApply animation: POPAnimation)

    func bottomCardView(popAnimationDidReach animation: POPAnimation)

    func bottomCardView(popAnimationDidStop animation: POPAnimation, finished: Bool)
}

public extension BottomCardViewDelegate {
    func bottomCardView(progressDidChangeFromPoint index: Int,
                        toPoint nextIndex: Int,
                        withProgress progress: CGFloat) {}

    func bottomCardView(viewHeightDidChange height: CGFloat) {}

    func bottomCardView(popAnimationDidStart animation: POPAnimation) {}

    func bottomCardView(popAnimationDidApply animation: POPAnimation) {}

    func bottomCardView(popAnimationDidReach animation: POPAnimation) {}

    func bottomCardView(popAnimationDidStop animation: POPAnimation, finished: Bool) {}
}

extension BottomCardView: POPAnimationDelegate {
    public func pop_animationDidStart(_ anim: POPAnimation!) {
        delegate?.bottomCardView(popAnimationDidStart: anim)
    }

    public func pop_animationDidApply(_ anim: POPAnimation!) {
        delegate?.bottomCardView(popAnimationDidApply: anim)
    }

    public func pop_animationDidReach(toValue anim: POPAnimation!) {
        delegate?.bottomCardView(popAnimationDidReach: anim)
    }

    public func pop_animationDidStop(_ anim: POPAnimation!, finished: Bool) {
        delegate?.bottomCardView(popAnimationDidStop: anim, finished: finished)
    }
}
