//
//  ViewController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDataSource, BottomCardViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomCardView: BottomCardView!
    @IBOutlet weak var tableViewInBottom: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var headerHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableViewInBottom.dataSource = self
        bottomCardView.addPoint(value: 400)
        bottomCardView.minPoint = 50
        bottomCardView.delegate = self
    
        bottomCardView.addScroll(for: tableViewInBottom)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bottomCardView.addPoint(value: self.view.bounds.height - view.safeAreaInsets.top + headerHeight.constant)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(Int.random(in: 0...100))
        return cell
    }

    func valueToPointDidChange(from: Int, to: Int, progress: CGFloat) {
     //  print("from point: \(from),to point: \(to), with progress \(progress)")
    }

    func heightDidChange(height: CGFloat) {
    }
}
