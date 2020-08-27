//
//  BottomCardDelegateTests.swift
//  BottomCardExampleTests
//
//  Created by Gulkov on 20.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import XCTest
@testable import BottomCard

class BottomCardDelegateTests: XCTestCase, BottomCardViewDelegate {

    func testProgressChanged() {
        let controller = TestableController()
        controller.viewDidLoad()
        controller.bottomCardView.changeHeight(value: 100, animation: .none)
        controller.bottomCardView.layoutSubviews()
        XCTAssertTrue(controller.progressChanged)
    }

    func testHeightChanged() {
        let controller = TestableController()
        controller.viewDidLoad()
        controller.bottomCardView.changeHeight(value: 100, animation: .none)
        controller.bottomCardView.layoutSubviews()
        XCTAssertTrue(controller.heightChanged)
    }

    func testAnimationStarted() {
        let controller = TestableController()
        controller.viewDidLoad()
        controller.bottomCardView.changeHeight(value: 100, animation: .basic(duration: 0.1))
        controller.bottomCardView.layoutSubviews()
        XCTAssertTrue(controller.animationStarted)
    }

    func testAnimationApplyed() {
        let controller = TestableController()
        controller.viewDidLoad()
        controller.bottomCardView.changeHeight(value: 100, animation: .basic(duration: 0.1))
        controller.bottomCardView.layoutSubviews()
        XCTAssertTrue(controller.animationApplyed)
    }
}
