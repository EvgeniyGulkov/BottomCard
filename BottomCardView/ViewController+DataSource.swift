//
//  ViewController+TableViewDelegate.swift
//  BottomCardView
//
//  Created by Gulkov on 13.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(Int.random(in: 0...100))
        return cell
    }
}
