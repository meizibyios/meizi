//
//  MyLoveViewController.swift
//  meizi
//
//  Created by xiaomo on 15/8/31.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//


import UIKit
import MJRefresh
class MyLoveViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBOutlet weak var itemTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemTableview.delegate=self
        itemTableview.dataSource=self
        itemTableview.header=MJRefreshNormalHeader(refreshingBlock: {
            println("1")
        })
        itemTableview.footer=MJRefreshAutoGifFooter(refreshingBlock: {
             println("1")
        })
        itemTableview.header.beginRefreshing()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 20
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell=MyLoveViewCell()
        return cell
    }
    
}
