//
//  LogInController.swift
//  meizi
//
//  Created by xmw on 15/9/25.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LogInController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   class func checkLogin(){
    var parameters=["username":"asdfas","password":"123456"]
        Alamofire.request(.POST, QiniuUtil.URL_LOGIN(), headers: QiniuUtil.getApiHeaders() as? [String : String],parameters:parameters
            )
            .responseJSON { _, _, Json, error in
                println(Json)
                
//                let json=SwiftyJSON.JSON(Json!)
                
        }

    }
  

}
