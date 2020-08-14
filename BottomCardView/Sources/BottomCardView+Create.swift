//
//  BottomCardView+Init.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension BottomCardView {

    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = true
        autoresizingMask = [.flexibleLeftMargin, .flexibleWidth, .flexibleTopMargin, .flexibleHeight, .flexibleRightMargin]
        addPoint(value: minPoint)
        height = minPoint
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }

    func createMask(radius: CGFloat) {
        let tempHeight = height
        height = UIScreen.main.bounds.height
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.reversing().cgPath
        layer.mask = shape
        height = tempHeight
    }

    public override func layoutSubviews() {
        if viewInsets == nil {
            viewInsets = safeAreaInsets
        }
        if frame.width != width {
            width = frame.width
        }
        self.getCurrentPoint()
        self.getNextPoint()
        self.delegate?.viewHeightDidChange(height: height)
        self.changeConstraintPriority()
    }

    private func changeConstraintPriority() {
        let constraints = superview?.constraints.filter {
            $0.firstAnchor == topAnchor ||
                $0.secondAnchor == topAnchor ||
                $0.firstAnchor == bottomAnchor ||
                $0.secondAnchor == bottomAnchor
        }
        constraints?.forEach {$0.priority = UILayoutPriority(rawValue: 1)}
    }
}
