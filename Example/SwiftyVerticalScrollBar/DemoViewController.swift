//
//  DemoViewController.swift
//  SwiftyVerticalScrollBar
//

import UIKit
import SwiftyVerticalScrollBar

class DemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate (set) var scrollBar : SwiftyVerticalScrollBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollBar = SwiftyVerticalScrollBar(frame: CGRect.zero, targetScrollView: self.tableView)
        self.view.addSubview(self.scrollBar!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollBar.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1000
    }
    
    func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath)
        cell.textLabel?.text = "cell : \(indexPath.row) "
        return cell
    }
}
