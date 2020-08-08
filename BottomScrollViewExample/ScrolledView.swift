//
//  ScrolledBottomController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

class ScrolledView: UIView, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var baseView: UIView!
    
    var previousPoint = CGPoint(x: 0, y: 0)
    var limit: CGFloat = 0
    var tableGesture: UIPanGestureRecognizer!

    private var topPoint: CGFloat!
    private var bottomPoint: CGFloat!
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
        Bundle.main.loadNibNamed("ScrolledView", owner: self, options: nil)
        baseView.frame = self.bounds
        self.addSubview(baseView)
        self.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.dataSource = self
        headerView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(headerTouched)))
        headerView.gestureRecognizers?.first?.delegate = self
        
        tableGesture = UIPanGestureRecognizer(target: self, action: #selector(tableViewTouched))
        tableView.addGestureRecognizer(tableGesture)
        tableGesture.delegate = self
        
        topPoint = frame.height
        bottomPoint = headerHeight.constant
        firstPoint = frame.height / 3
        secondPoint = firstPoint * 2
        containerViewHeight.constant = bottomPoint
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
        if containerViewHeight.constant < secondPoint - firstPoint / 2,
            containerViewHeight.constant > firstPoint / 2 {
            moveWithAnimation(point: firstPoint)
        }
        if containerViewHeight.constant < firstPoint / 2 {
            moveWithAnimation(point: bottomPoint)
        }
        if containerViewHeight.constant > secondPoint - (secondPoint - firstPoint) / 2,
            containerViewHeight.constant < topPoint - (topPoint - secondPoint) / 2 {
            moveWithAnimation(point: secondPoint)
        }
        if containerViewHeight.constant > topPoint - (topPoint - secondPoint) / 2 {
            moveWithAnimation(point: topPoint)
        }
    }

    private func moveWithAnimation(point: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.containerViewHeight.constant = point
            self.containerView.layoutIfNeeded()
        })
    }

    // MARK: - Selectors
    @objc
    func tableViewTouched(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            limit = tableView.contentSize.height - tableView.visibleSize.height
            let point = tableView.panGestureRecognizer.location(in: self)
            let difference = previousPoint.y - point.y
            if round(tableView.contentOffset.y) >= round(limit), difference > 0 {
                changeSize(difference: difference)
            }
            if round(tableView.contentOffset.y) <= 0, difference < 0 {
                changeSize(difference: difference)
                
            }
            previousPoint = tableView.panGestureRecognizer.location(in: self)
        } else if sender.state == .ended {
            moveToPoint()
        }
    }

    @objc
    func headerTouched(_ sender: UIPanGestureRecognizer) {
        if sender.state == .changed {
            let point = sender.location(in: self)
            let difference = previousPoint.y - point.y
            changeSize(difference: difference)
            previousPoint = sender.location(in: self)
        } else if sender.state == .ended {
            moveToPoint()
        }
    }

    // MARK: - Gesture delegate
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        previousPoint = gestureRecognizer.location(in: self)
        limit = tableView.contentSize.height - tableView.visibleSize.height
        return true
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(Int.random(in: 0...1000))
        return cell
    }
}
