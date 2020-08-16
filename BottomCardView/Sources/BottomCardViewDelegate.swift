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
}

public extension BottomCardViewDelegate {
    func bottomCardView(progressDidChangeFromPoint index: Int,
                        toPoint nextIndex: Int,
                        withProgress progress: CGFloat) {}

    func bottomCardView(viewHeightDidChange height: CGFloat) {}
}
