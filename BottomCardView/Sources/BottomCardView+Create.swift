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
    }

    public override func layoutSubviews() {
        getCurrentPoint()
        changeConstraintPriority()
        let nextPoint = self.getNextPoint()
        let progress = getProgressValue(nextPointIndex: nextPoint)
        delegate?.bottomCardView(progressDidChangeFromPoint: currentPointIndex, toPoint: nextPoint, withProgress: progress)
        delegate?.bottomCardView(viewHeightDidChange: height)
    }

    private func changeConstraintPriority() {
        let constraints = superview?.constraints.filter {
            $0.firstAnchor == topAnchor ||
                $0.secondAnchor == topAnchor ||
                $0.firstAnchor == bottomAnchor ||
                $0.secondAnchor == bottomAnchor
        }
        constraints?.forEach {
            $0.isActive = false
        }
    }
}
