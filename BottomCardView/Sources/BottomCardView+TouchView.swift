//
//  BottomCardView+HitTest.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import MapKit

extension BottomCardView {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let superView = superview else {return}
        let point = touches.first!.location(in: superView)
        viewTouched(state: .began, point: point)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let superView = superview, !touchInMapView(touch: touches.first!) else {return}
        let point = touches.first!.location(in: superView)
        viewTouched(state: .moved, point: point)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let superView = superview else {return}
        let point = touches.first!.location(in: superView)
        viewTouched(state: .ended, point: point)
    }

    func touchInMapView(touch: UITouch) -> Bool {
        if let view = subviews.first(where: {$0 is MKMapView}) {
            let point = touch.location(in: view)
            if view.frame.contains(point) {
                return true
            }
        }
        return false
    }
}
