//
//  ScrolledBottomController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

enum Direction {
    case up
    case down
}

protocol ScrolledViewDelegate: class {
    func valueToPointDidChange(value: CGFloat)
    func heightDidChange(height: CGFloat)
}

class ScrolledView: UIView, UIGestureRecognizerDelegate {
    private let headerDefaultHeight: CGFloat = 44

    weak var delegate: ScrolledViewDelegate?

    var headerView: UIView!
    
    // if enabled container will be hidden
    var hideOnTapSuperView: Bool = false

    var titleLabel: UILabel!

    var maxPoint: CGFloat = 1 {
        didSet {
            if maxPoint > 1 {
                rawPoints[1] = 1
            } else {
                rawPoints[1] = maxPoint
            }
        }
    }

    var minPoint: CGFloat = 0 {
        didSet {
            if minPoint < 0 {
                rawPoints[0] = 0
            } else {
                rawPoints[0] = minPoint
            }
        }
    }

    private var containerView: UIView!
    private var containerViewHeight: NSLayoutConstraint!

    private var points: [CGFloat] { return rawPoints.sorted(by: <).filter {$0 <= 1.0 && $0 >= 0} }

    private var previousPoint = CGPoint(x: 0, y: 0)
    private var limit: CGFloat = 0
    private var currentPointIndex = 0
    private var rawPoints: [CGFloat] = []

    private var height: CGFloat {
        get {
            return containerViewHeight.constant
        }
        set {
            containerViewHeight.constant = newValue
            getProgressValue()
            delegate?.heightDidChange(height: newValue)
        }
    }

    private var openValue: CGFloat = 0 {
        didSet {
            height = (self.bounds.height - headerView.bounds.height) * openValue
        }
    }

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
        rawPoints.append(contentsOf: [minPoint, maxPoint])
    }

    func addScroll( for scrollView: UIScrollView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(scrollViewScrolled))
        gesture.delegate = self
        scrollView.addGestureRecognizer(gesture)
    }

    func addPoint(value: CGFloat) {
        rawPoints.append(value)
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

    //MARK: - Private

    private func createContainer() {
        guard containerView == nil else {return}
        containerView = UIView()
        containerView.backgroundColor = .darkGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        super.addSubview(containerView)

        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: self.bounds.width).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalToConstant: minPoint)
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

    private func changeSize(difference: CGFloat) {
        if difference > 0, height <= self.bounds.height {
            if points.count > 2 {
                guard height < getHeightForPoint(point: maxPoint) else {return}
            }
            height += difference
            getCurrentPoint(direction: .up)
            return
        }
        if difference < 0, height >= minPoint {
            if points.count > 2 {
                 guard height > getHeightForPoint(point: minPoint) else {return}
             }
            height += difference
            getCurrentPoint(direction: .down)
            return
        }
    }

    private func getCurrentPoint(direction: Direction) {
        if direction == .up {
            guard currentPointIndex != points.count - 1 else {return}
            let nextPointHeight = getHeightForPoint(point: points[currentPointIndex + 1])
            if height >= nextPointHeight {
                currentPointIndex = currentPointIndex + 1
            }
        } else if currentPointIndex != 0 {
            let nextPointHeight = getHeightForPoint(point: points[currentPointIndex])
            if height <= nextPointHeight {
                currentPointIndex = currentPointIndex - 1
            }
        }
    }

    private func getHeightForPoint(point: CGFloat) -> CGFloat {
        return (self.bounds.height - headerView.bounds.height) * point
    }

    private func moveToPointWithAnimation() {
        var nearestPoint = points[currentPointIndex]
        var minValue: CGFloat = .infinity
        for point in points {
            let pointHeight = point * self.bounds.height
            let difference = abs(pointHeight - height)
            if difference < minValue {
                minValue = difference
                nearestPoint = point
            }
        }
        UIView.animate(withDuration: 0.2, animations: {
            self.openValue = nearestPoint
            self.layoutIfNeeded()
        })
    }

    private func getProgressValue() {
        guard currentPointIndex != points.count - 1 else {return}
        let currentPointHeight = getHeightForPoint(point: points[currentPointIndex])
        let nextPointHeight = getHeightForPoint(point: points[currentPointIndex + 1])
        let currentHeight = height - currentPointHeight
        let length = (nextPointHeight - currentPointHeight)
        var valueToNextPoint: CGFloat = 0
        if height == getHeightForPoint(point: points[currentPointIndex]) {
            valueToNextPoint = 0
        } else {
            valueToNextPoint = currentHeight / length
        }
        delegate?.valueToPointDidChange(value: valueToNextPoint)
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
            moveToPointWithAnimation()
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
            moveToPointWithAnimation()
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
