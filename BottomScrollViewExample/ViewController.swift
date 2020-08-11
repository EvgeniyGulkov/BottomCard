//
//  ViewController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, BottomCardViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomCardView: BottomCardView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var textView3: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        bottomCardView.addPoint(value: 600)
        bottomCardView.addPoint(value: 400)
        bottomCardView.minPoint = 20
        bottomCardView.delegate = self

        bottomCardView.addScroll(for: textView)
        bottomCardView.addScroll(for: textView2)
        bottomCardView.addScroll(for: textView3)
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
        print("from point: \(from),to point: \(to), with progress \(progress)")
    }
    
    func heightDidChange(height: CGFloat) {
    }
}
