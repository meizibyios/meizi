//
//  MyLoveViewController.swift
//  meizi
//
//  Created by xiaomo on 15/8/31.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//


import UIKit

class MyLoveViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    @IBAction func backClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    @IBOutlet weak var itemTableview: UITableView!
    var itemArray:NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        weak var weakSelf=self
//        self.navigationController!.interactivePopGestureRecognizer.enabled = true
//        if self.respondsToSelector(Selector("interactivePopGestureRecognizer"))
//        {
////            self.interactivePopGestureRecognizer.delegate = weakSelf;
//            self.navigationController?.interactivePopGestureRecognizer.delegate=weakSelf
//        }
        initdata()
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
    func initdata(){
        itemArray=NSMutableArray(contentsOfFile: GlobalVariables.getMyLovePlistPath())!.mutableCopy() as! NSMutableArray
    }
    // tableveiew
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MyLoveViewCell") as! MyLoveViewCell
//        var rect=cell.imageView?.frame
//        rect?.size.width=self.view.frame.size.width-200
//        cell.imageView?.frame=rect!
//        cell.imageView?.contentMode=UIViewContentMode.ScaleAspectFit
        cell.imageView?.sd_setImageWithURL( NSURL( string: GlobalVariables.loveBizhiUrl21920_1200_2(itemArray.objectAtIndex(indexPath.row) as! String)) )
//        cell.imageView?.sd_setImageWithURL(url: NSURL!, placeholderImage: <#UIImage!#>)
        
        return cell
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        startItemDetilViewController(itemArray.objectAtIndex(indexPath.row) as!String)
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.endEditing(true)
        if editingStyle  == UITableViewCellEditingStyle.Delete
        {
            itemArray.removeObjectAtIndex(indexPath.row)
            var array=NSMutableArray()
            array.addObject(indexPath)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
            itemArray.writeToFile(GlobalVariables.getMyLovePlistPath(), atomically: true)
        }
    }
    
    
    func startItemDetilViewController(imageUrl:String )// 图片详情
    {
        var storyboard=UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        vc.imageUrl=imageUrl as String
        self.presentViewController(vc, animated: true,completion:nil);
    }

    
}
