//
//  ViewController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, ScrolledViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrolledView: ScrolledView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textView2: UITextView!
    @IBOutlet weak var textView3: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        scrolledView.addPoint(value: 600)
        scrolledView.addPoint(value: 400)
        scrolledView.minPoint = 20
        scrolledView.delegate = self

        scrolledView.addScroll(for: textView)
        scrolledView.addScroll(for: textView2)
        scrolledView.addScroll(for: textView3)
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
