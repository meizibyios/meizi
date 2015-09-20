///
//  GlobalVariables.swift
//  meizi
//
//  Created by xmw on 15/9/6.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit

class GlobalVariables: NSObject {
    class func loveBizhiUrl ( type:NSInteger, page:NSInteger)->String {return "http://api.lovebizhi.com/macos_v4.php?a=category&spdy=1&tid=\(type)&order=hot&color_id=3&device=105&uuid=436e4ddc389027ba3aef863a27f6e6f9&mode=0&retina=0&client_id=1008&device_id=31547324&model_id=105&size_id=0&channel_id=70001&screen_width=1920&screen_height=1200&bizhi_width=480&bizhi_height=300&version_code=19&language=zh-Hans&jailbreak=0&mac=&p=\(page)"}
    
    /** 收藏列表文件名**/
    class func getMyLovePlistPath()-> String{
        var myloveplistPath1=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) ;
        let documentsDirectory: AnyObject = myloveplistPath1[0]
        let plistPath=documentsDirectory.stringByAppendingPathComponent("love")
        let array=NSMutableArray(contentsOfFile: plistPath)
        if array==nil{
            let arraytemp=NSArray()
            arraytemp.writeToFile(plistPath, atomically: true)
            
        }
        
        return plistPath
    }
    /** 用户信息文件名**/
    class func getUserPath()-> String{
        var myloveplistPath1=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) ;
        let documentsDirectory: AnyObject = myloveplistPath1[0]
        let plistPath=documentsDirectory.stringByAppendingPathComponent("user")
        let dic=NSMutableDictionary(contentsOfFile: plistPath)
        if dic==nil{
            let arraytemp=NSDictionary()
            arraytemp.writeToFile(plistPath, atomically: true)
            
        }
        
        return plistPath
    }
    /**是否在审核期间***/
    class func notInView()-> Bool
    {
        let comdate=NSDateComponents()
        comdate.month=9
        comdate.year=2015
        comdate.day=10
        let caldate=NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let mydata=caldate?.dateFromComponents(comdate)
        let nowdate=NSDate()
        
        nowdate.laterDate(mydata!)
        if(nowdate.laterDate(mydata!).isEqual(nowdate))
        {
            return true
        }
        return false
    }
    class func getImageFromSD(key:String)->UIImage
    {
        return QiniuUtiloc.getImageFromSD(key)
    }
    
}
