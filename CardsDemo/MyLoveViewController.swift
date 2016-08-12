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
        var rect=self.view.frame
        rect.size.width-=10
        itemTableview.frame=rect
        itemTableview.rowHeight=(rect.width-10)*30/48
        initdata()
        itemTableview.delegate=self
        itemTableview.dataSource=self
        itemTableview.header=MJRefreshNormalHeader(refreshingBlock: {
          
            self.itemTableview.header.endRefreshing()
        })
        itemTableview.footer=MJRefreshAutoGifFooter(refreshingBlock: {
           
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
//        var cell = tableView.dequeueReusableCellWithIdentifier("MyLoveViewCellhead") as! MyLoveViewCell
//
//        static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
//        //    用TableSampleIdentifier表示需要重用的单元
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableSampleIdentifier];
//        //    如果如果没有多余单元，则需要创建新的单元
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:TableSampleIdentifier];
//        }  
        
//        if cell.
//        {
          let  cell=MyLoveViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "MyLoveViewCellhead") as MyLoveViewCell
            let imageview=UIImageView()
            var rect=self.view.frame
            rect.size.height=tableView.rowHeight
            imageview.frame=rect
            imageview.contentMode=UIViewContentMode.ScaleAspectFit
            cell.addSubview(imageview)
            cell.imageview=imageview
//        }
//        var rect=cell.imageView?.frame
//        rect?.size.width=self.view.frame.size.width-100
//        cell.imageView?.frame=rect!
//        cell.imageView?.contentMode=UIViewContentMode.ScaleAspectFit
        cell.imageview.sd_setImageWithURL( NSURL(string :itemArray.objectAtIndex(indexPath.row) as! String) )
        
        return cell
    }
   
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
      startItemDetilViewController(PicItem(identifyorurl: itemArray.objectAtIndex(indexPath.row) as!String))
//        showHost(tableView, indexPath: indexPath, index: indexPath.row)
    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        tableView.endEditing(true)
        if editingStyle  == UITableViewCellEditingStyle.Delete
        {
            itemArray.removeObjectAtIndex(indexPath.row)
            let array=NSMutableArray()
            array.addObject(indexPath)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Bottom)
            itemArray.writeToFile(GlobalVariables.getMyLovePlistPath(), atomically: true)
        }
    }
    
    
    func startItemDetilViewController(picItem:PicItem)// 图片详情
    {
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("StoryViewController") as! StoryViewController
        vc.picItem=picItem;
        self.presentViewController(vc, animated: true,completion:nil);
    }
    
}
