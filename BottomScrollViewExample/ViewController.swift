//
//  ViewController.swift
//  BottomScrollViewExample
//
//  Created by Gulkov on 04.08.2020.
//  Copyright © 2020 Gulkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    private let mockText = """
    FSDHFIUSHD IUHFISD HFIUSHDIFUH ISDUHF IUSHD FIUHSDI
    FUHSIDFHIUSHIFUHSDIUFHIS DHFISDH FSDFSGUDFGHWOIEFJOSE
    FHOSDFH SUDFSDHF OISDF SDFSD FSD FS DFS DF SDF SDF SDF
    SDF SDF SDF SDF SD FSD FIFHISDUHFIU ISUDHFISUDFIH IUSHDFIU
    FSDHFIUSHD IUHFISD HFIUSHDIFUH ISDUHF IUSHD FIUHSDI
    FUHSIDFHIUSHIFUHSDIUFHIS DHFISDH FSDFSGUDFGHWOIEFJOSE
    FHOSDFH SUDFSDHF OISDF SDFSD FSD FS DFS DF SDF SDF SDF
    SDF SDF SDF SDF SD FSD FIFHISDUHFIU ISUDHFISUDFIH IUSHDFIU
    FSDHFIUSHD IUHFISD HFIUSHDIFUH ISDUHF IUSHD FIUHSDI
    FUHSIDFHIUSHIFUHSDIUFHIS DHFISDH FSDFSGUDFGHWOIEFJOSE
    FHOSDFH SUDFSDHF OISDF SDFSD FSD FS DFS DF SDF SDF SDF
    SDF SDF SDF SDF SD FSD FIFHISDUHFIU ISUDHFISUDFIH IUSHDFIU
    """
 @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let scrolledView = ScrolledView(frame: self.view.bounds)
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        textView.bounces = false
        textView.text = mockText
        view.addSubview(scrolledView)
        scrolledView.addSubview(textView)
        scrolledView.addScroll(for: textView)
        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = String(Int.random(in: 0...100))
        return cell
    }
}
