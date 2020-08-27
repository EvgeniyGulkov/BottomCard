//
//  TestableController.swift
//  BottomCardExampleTests
//
//  Created by Gulkov on 21.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import XCTest
import pop
@testable import BottomCard

class TestableController: UIViewController, BottomCardViewDelegate  {
    var bottomCardView: BottomCardView!

    var progressChanged = false
    var heightChanged = false
    var animationStarted = false
    var animationStopped = false
    var animationReached = false
    var animationApplyed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomCard()
    }

    func setupBottomCard() {
        self.bottomCardView = BottomCardView()
        bottomCardView.addPoint(value: 400)
        bottomCardView.addPoint(value: .infinity)
        bottomCardView.minPoint = 20
        bottomCardView.delegate = self
        bottomCardView.side = .top
        view.addSubview(bottomCardView)
    }

    func bottomCardView(progressDidChangeFromPoint index: Int, toPoint nextIndex: Int, withProgress progress: CGFloat) {
        progressChanged = true
    }

    func bottomCardView(viewHeightDidChange height: CGFloat) {
        heightChanged = true
    }

    func bottomCardView(popAnimationDidStart animation: POPAnimation) {
        animationStarted = true
    }

    func bottomCardView(popAnimationDidApply animation: POPAnimation) {
        animationApplyed = true
    }

    func bottomCardView(popAnimationDidReach animation: POPAnimation) {
        animationReached = true
    }

    func bottomCardView(popAnimationDidStop animation: POPAnimation, finished: Bool) {
        animationStopped = true
    }
}
