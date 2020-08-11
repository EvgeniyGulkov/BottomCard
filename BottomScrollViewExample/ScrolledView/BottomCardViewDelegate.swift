//
//  BottomCardViewDelegate.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 10.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

protocol BottomCardViewDelegate: class {
    func valueToPointDidChange(from: Int, to: Int, progress: CGFloat)
    func heightDidChange(height: CGFloat)
}
