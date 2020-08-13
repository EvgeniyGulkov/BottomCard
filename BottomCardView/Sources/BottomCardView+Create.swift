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
        autoresizingMask = [.flexibleBottomMargin, .flexibleHeight, .flexibleLeftMargin, .flexibleRightMargin, .flexibleTopMargin, .flexibleWidth]
        addPoint(value: minPoint)
        height = minPoint
    }

    func createMask(radius: CGFloat) {
        guard let superView = superview else {return}
        let tempHeight = height
        height = superView.bounds.height
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.reversing().cgPath
        layer.mask = shape
        height = tempHeight
    }

    override func layoutSubviews() {
        if viewInsets == nil {
            viewInsets = safeAreaInsets
        }
        if frame.width != width {
            width = frame.width
        }
        self.getCurrentPoint()
        self.getNextPoint()
        self.delegate?.heightDidChange(height: height)
    }
}
