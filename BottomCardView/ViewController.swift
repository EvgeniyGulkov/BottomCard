//
//  ViewController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, BottomCardViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomCardView: BottomCardView!
    @IBOutlet weak var tableViewInBottom: UITableView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableViewInBottom.dataSource = self
        setupBottomCard()
    }

    func setupBottomCard() {
        bottomCardView.addPoint(value: 400)
        bottomCardView.addPoint(value: .infinity)
        bottomCardView.minPoint = 30
        bottomCardView.delegate = self
        bottomCardView.cornerRadius = 20
        bottomCardView.addScroll(for: tableViewInBottom)
    }

    func valueToPointDidChange(from: Int, to: Int, progress: CGFloat) {
        if from == 0, to == 1 {
            let color = headerView.backgroundColor
            headerView.backgroundColor = color?.withAlphaComponent(1 - progress)
        }
        if from == 1, to == 0 {
            let color = headerView.backgroundColor
            headerView.backgroundColor = color?.withAlphaComponent(progress)
        }
    }
}
