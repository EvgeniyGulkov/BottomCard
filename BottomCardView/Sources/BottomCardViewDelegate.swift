//
//  BottomCardViewDelegate.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

protocol BottomCardViewDelegate: class {
    func progressToPointDidChange(from: Int, to: Int, progress: CGFloat)
    func viewHeightDidChange(height: CGFloat)
    func springAnimationComplete(inPoint: Int, onHeight: CGFloat)
}

extension BottomCardViewDelegate {
    func progressToPointDidChange(from: Int, to: Int, progress: CGFloat) {}
    func viewHeightDidChange(height: CGFloat) {}
    func springAnimationComplete(inPoint: Int, onHeight: CGFloat) {}
}
