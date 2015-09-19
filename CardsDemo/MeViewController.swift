//
//  MeViewController.swift
//  meizi
//
//  Created by xmw on 15/9/16.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class MeViewController: UIViewController {
    static var user:ThisUser!
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
    
    
    class func logIn(){
       var dic = NSMutableDictionary(contentsOfFile: GlobalVariables.getUserPath())
        var type=dic?.objectForKey("usetype") as! String
        if type.isEmpty
        {
            MeViewController.createDEfaultUser()
        }else {
            MeViewController.user=ThisUser.getUserFromDic(dic!)
        }
        
    }
    class func checkLogin(){
        
    }
    class func createDEfaultUser()->ThisUser{
        var username="\(NSDate().timeIntervalSince1970)\(arc4random()%100)"
        var defaultpassword="zvaewaasdf1"
        
        var user = ThisUser(userNmae: username, userId: "", userWChartId: "", userType: "0", userPSW: defaultpassword)
        let headers = [
            "apikey": "77b2f247303ebca204a45170448412b6"
        ]
        let parameters = [
            "num": "40"
        ]
        
        
        Alamofire.request(.GET, "http://apis.baidu.com/txapi/mvtp/meinv?num=40", headers: headers,parameters:parameters
            )
            .responseJSON { _, _, Json, _ in
                println(Json)
                let json=SwiftyJSON.JSON(Json!)
               
                
        }
        return user
    }

}
