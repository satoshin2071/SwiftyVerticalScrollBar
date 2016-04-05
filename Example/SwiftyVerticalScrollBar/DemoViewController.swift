//
//  DemoViewController.swift
//  SwiftyVerticalScrollBar
//

import UIKit
import SwiftyVerticalScrollBar

class DemoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private (set) var scrollBar : SwiftyVerticalScrollBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.scrollBar = SwiftyVerticalScrollBar(frame: CGRectZero, targetScrollView: self.tableView)
        self.view.addSubview(self.scrollBar!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1000
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DemoCell", forIndexPath: indexPath)
        cell.textLabel?.text = "cell : \(indexPath.row) "
        return cell
    }
}
