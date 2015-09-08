//
//  GlobalVariables.swift
//  meizi
//
//  Created by xmw on 15/9/6.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit

class GlobalVariables: NSObject {
    class func loveBizhiUrl ( page:NSInteger)->String {return "http://api.lovebizhi.com/macos_v4.php?a=category&spdy=1&tid=3&order=hot&color_id=3&device=105&uuid=436e4ddc389027ba3aef863a27f6e6f9&mode=0&retina=0&client_id=1008&device_id=31547324&model_id=105&size_id=0&channel_id=70001&screen_width=1920&screen_height=1200&bizhi_width=480&bizhi_height=300&version_code=19&language=zh-Hans&jailbreak=0&mac=&p=\(page)"}
    class func loveBizhiUrl21920_1200 (url :String)->String{
        return url.stringByReplacingOccurrencesOfString("480", withString: "1920", options: nil, range: nil).stringByReplacingOccurrencesOfString("300", withString: "1200", options: nil, range: nil)
    }
   
    class func getMyLovePlistPath()-> String{
    

        var myloveplistPath1=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) ;
        var documentsDirectory: AnyObject = myloveplistPath1[0]
        var plistPath=documentsDirectory.stringByAppendingPathComponent("love")
        var array=NSMutableArray(contentsOfFile: plistPath)
        if array==nil{
            var arraytemp=NSArray()
            arraytemp.writeToFile(plistPath, atomically: true)
            
        }
        
        return plistPath
    }
    
   
}
