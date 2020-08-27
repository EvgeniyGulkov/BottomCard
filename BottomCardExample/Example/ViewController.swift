//
//  ViewController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import MapKit
import pop

class ViewController: UIViewController, BottomCardViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomCardView: BottomCardView!
    @IBOutlet weak var tableViewInBottom: UITableView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var tableViewTopConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableViewInBottom.dataSource = self
        setupBottomCard()
    }

    func setupBottomCard() {
        bottomCardView.addPoint(value: 400)
        bottomCardView.addPoint(value: .infinity)
        bottomCardView.minPoint = 20
        bottomCardView.delegate = self
        bottomCardView.addScroll(for: tableViewInBottom)
        bottomCardView.side = .top
        headerHeight.constant = navigationController!.navigationBar.frame.height
    }

    override func viewDidLayoutSubviews() {
        bottomCardView.insets = view.safeAreaInsets
    }

    func bottomCardView(viewHeightDidChange height: CGFloat) {
        tableViewTopConstraint.constant = height
    }
}
