//
//  ViewAnimatorTests.swift
//  BottomCardExampleTests
//
//  Created by Gulkov on 20.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import XCTest
import pop
@testable import BottomCard

class ViewAnimatorTests: XCTestCase {
    private let springAnimationKey = "kPOPViewFrameSpring"
    private let basicAnimationKey = "kPOPViewFrameBasic"
    let expectation = XCTestExpectation(description: "AnimationComplete")

    func testBasicAnimationComplete() {
        let view = BottomCardView()
        view.side = .top
        view.insets?.top = 1000
        ViewAnimator.topAnimation(view: view, to: 1000, duration: 0.1, { animation, complete in
            XCTAssertTrue(complete)
            self.expectation.fulfill()
        })
        wait(for: [expectation], timeout: 5)
    }

    func testBasicAnimationFailed() {
        let view = BottomCardView()
        ViewAnimator.topAnimation(view: view, to: 100, duration: 0.1, { animation, complete in
            XCTAssertFalse(complete)
        })
        view.removeAllAnimations()
    }

    func testSpringAnimationComplete() {
        let view = BottomCardView()
        view.side = .top
        view.insets?.top = 1000
        ViewAnimator.topSpringAnimation(view: view, to: 1000, bounces: 10, speed: 10) { animation, complete in
            XCTAssertTrue(complete)
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }

    func testSpringAnimationFailed() {
        let view = BottomCardView()
        ViewAnimator.topSpringAnimation(view: view, to: 1000, bounces: 10, speed: 10) { animation, complete in
            XCTAssertFalse(complete)
        }
        view.removeAllAnimations()
    }
}
