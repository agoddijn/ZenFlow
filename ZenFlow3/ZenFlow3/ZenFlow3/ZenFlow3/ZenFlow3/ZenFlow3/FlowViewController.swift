//
//  FlowViewController.swift
//  ZenFlow3
//
//  Created by Alexander Goddijn on 14/03/2015.
//  Copyright (c) 2015 Alexander Goddijn. All rights reserved.
//

import Foundation
import UIKit

class FlowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var curRow = 1
    var timer: NSTimer?
    
    @IBOutlet weak var tableView: UITableView!
    var myManager: PhotoManager = PhotoManager()
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.width
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageViewCell", forIndexPath: indexPath) as ImageCellTableViewCell
        
        if let photo = myManager.pop() {
            cell.contentImage.image = photo
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        myManager.populatePhotos()
        return myManager.photos.length
    }
    
    func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.scrollEnabled = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func viewWillAppear(animated: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("scroll"), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        if (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) != nil) {
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        }
    }
    
    func scroll() {
        if (tableView.cellForRowAtIndexPath(NSIndexPath(forRow: curRow, inSection: 0)) != nil) {
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: curRow, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            tableView.scrollToNearestSelectedRowAtScrollPosition(UITableViewScrollPosition.Middle, animated: true)
            curRow++
        } else {
            timer!.invalidate()
            timer = nil
            curRow = 1
        }
    }
    
    override func viewDidDisappear(animated: Bool) {
        if (timer != nil) {
            timer!.invalidate()
            timer = nil
        }
        curRow = 1
    }
    
}
