//
//  MyLoveViewController.swift
//  meizi
//
//  Created by xiaomo on 15/8/31.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//


import UIKit

class MyLoveViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var itemTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableview.delegate=self
        itemTableview.dataSource=self
        itemTableview.header=MJRefreshNormalHeader(refreshingBlock: {
            println("1")
            self.itemTableview.header.endRefreshing()
        })
        itemTableview.footer=MJRefreshAutoGifFooter(refreshingBlock: {
             println("1")
             self.itemTableview.footer.endRefreshing()
        })
        itemTableview.header.beginRefreshing()
    }
    // tableveiew
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MyLoveViewCell") as! MyLoveViewCell
        return cell
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        startItemDetilViewController()
    }
    func startItemDetilViewController()// 图片详情
    {
        var storyboard=UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        self.presentViewController(vc, animated: true,completion:nil);
    }

    
}
