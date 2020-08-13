//
//  BottomCardView+GestureDelegate.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 11.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension BottomCardView: UIGestureRecognizerDelegate {

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
