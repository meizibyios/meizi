//
//  AboutMeViewController.swift
//  meizi
//
//  Created by xmw on 15/9/9.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit

class AboutMeViewController: UIViewController {

    @IBAction func backClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        
    })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
