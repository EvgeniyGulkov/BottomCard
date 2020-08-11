//
//  ScrolledView+Init.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension ScrolledView {
    
    func commonInit() {
        createContainer()
        pointsRaw.append(contentsOf: [minPoint])
    }

    private func createContainer() {
        translatesAutoresizingMaskIntoConstraints = false
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: 15, height: 15))
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
