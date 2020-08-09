//
//  ScrolledBottomController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

class ScrolledView: UIView, UIGestureRecognizerDelegate {
    private let headerDefaultHeight: CGFloat = 44
    private var containerView: UIView!
    var headerView: UIView!

    var points: [CGFloat] = []

    var openValue: CGFloat = 0 {
        didSet {
            containerViewHeight.constant = self.bounds.height * openValue
        }
    }

    var hideOnTapSuperView: Bool = true

    var titleLabel: UILabel!
    private var containerViewHeight: NSLayoutConstraint!
    private var previousPoint = CGPoint(x: 0, y: 0)
    private var limit: CGFloat = 0

    private var topPoint: CGFloat {
        return self.bounds.height - headerView.bounds.height
    }
    private var bottomPoint: CGFloat = 0
    private var firstPoint: CGFloat!
    private var secondPoint: CGFloat!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        createContainer()
    }

    func addScroll( for scrollView: UIScrollView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(scrollViewScrolled))
        gesture.delegate = self
        scrollView.addGestureRecognizer(gesture)
    }

    func addPoint(value: CGFloat) {
        points.append(value)
    }

    override func addSubview(_ view: UIView) {
        containerView.addSubview(view)
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view == self {
            if hideOnTapSuperView {
                openValue = 0
            }
            return nil
        }
        return view
    }

    private func createContainer() {
        guard containerView == nil else {return}
        containerView = UIView()
        containerView.backgroundColor = .darkGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        super.addSubview(containerView)

        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: bottomPoint)
        containerViewHeight.isActive = true
        createHeader()
    }

    private func createHeader() {
        headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: headerDefaultHeight))
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .systemYellow
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(headerTouched))
        headerView.addGestureRecognizer(gesture)
        super.addSubview(headerView)

        // setup headerView
        headerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: headerDefaultHeight).isActive = true
        
        let maskPath = UIBezierPath(roundedRect: headerView.bounds,
                                    byRoundingCorners: [.topRight, .topLeft],
                                    cornerRadii: CGSize(width: 15, height: 15))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        headerView.layer.mask = shape
        addTitle()
    }

    private func addTitle() {
        titleLabel = UILabel(frame: headerView.bounds)
        titleLabel.text = "Title"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
    }

    //MARK: - Private
    private func changeSize(difference: CGFloat) {
        if difference > 0, containerViewHeight.constant <= topPoint {
            containerViewHeight.constant += difference
            return
        }
        if difference < 0, containerViewHeight.constant >= bottomPoint {
            containerViewHeight.constant += difference
            return
        }
    }

    private func moveToPoint() {
      //  if containerViewHeight.constant < secondPoint - firstPoint / 2,
      //      containerViewHeight.constant > firstPoint / 2 {
      //      moveWithAnimation(point: firstPoint)
      //  }
     //   if containerViewHeight.constant < firstPoint / 2 {
     //       moveWithAnimation(point: bottomPoint)
     //   }
     //   if containerViewHeight.constant > secondPoint - (secondPoint - firstPoint) / 2,
     //       containerViewHeight.constant < topPoint - (topPoint - secondPoint) / 2 {
     //       moveWithAnimation(point: secondPoint)
    //    }
    //    if containerViewHeight.constant > topPoint - (topPoint - secondPoint) / 2 {
    //        moveWithAnimation(point: topPoint)
    //    }
    }

    private func moveWithAnimation(point: CGFloat) {
      //  UIView.animate(withDuration: 0.1, animations: {
       //     self.containerViewHeight.constant = point
      //      self.containerView.layoutIfNeeded()
      //  })
    }

    // MARK: - Selectors
    @objc
    private func scrollViewScrolled(_ sender: UIPanGestureRecognizer) {
        guard let scrollView = sender.view as? UIScrollView else {return}
        if sender.state == .changed {
            limit = scrollView.contentSize.height - scrollView.visibleSize.height
            let point = scrollView.panGestureRecognizer.location(in: self)
            let difference = previousPoint.y - point.y
            if round(scrollView.contentOffset.y) >= round(limit), difference > 0 {
                changeSize(difference: difference)
            }
            if round(scrollView.contentOffset.y) <= 0, difference < 0 {
                changeSize(difference: difference)
                
            }
            previousPoint = scrollView.panGestureRecognizer.location(in: self)
        } else if sender.state == .ended {
         //   moveToPoint()
        }
    }

    @objc
    private func headerTouched(_ sender: UIPanGestureRecognizer) {
        if sender.state == .began {
            previousPoint = sender.location(in: self)
        } else if sender.state == .changed {
            let point = sender.location(in: self)
            let difference = previousPoint.y - point.y
            changeSize(difference: difference)
            previousPoint = sender.location(in: self)
        } else if sender.state == .ended {
            //  moveToPoint()
        }
    }

    // MARK: - Gesture delegate
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let scrollView = gestureRecognizer.view as? UIScrollView else {return false}
        previousPoint = gestureRecognizer.location(in: self)
        limit = scrollView.contentSize.height - scrollView.visibleSize.height
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
