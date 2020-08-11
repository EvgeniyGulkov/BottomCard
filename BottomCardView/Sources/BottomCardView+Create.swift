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
        translatesAutoresizingMaskIntoConstraints = false
        addPoint(value: minPoint)
        cornerRadius = 15
    }

    func createMask(radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: UIScreen.main.bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        superview?.constraints.first(where: {$0.firstAnchor == topAnchor})?.isActive = false
        containerViewHeight = heightAnchor.constraint(equalToConstant: minPoint)
        containerViewHeight.isActive = true
    }
}
