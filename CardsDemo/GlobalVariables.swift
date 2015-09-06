//
//  GlobalVariables.swift
//  meizi
//
//  Created by xmw on 15/9/6.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit

class GlobalVariables: NSObject {
//    static var myloveplistPath=NSBundle.mainBundle().pathForResource("mylove", ofType: "plist")
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
//    static var myloveplistPath=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true);
    class func getMyLovePlistPath()-> String{
    
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        
//        NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
        var myloveplistPath=NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true) as! NSArray;
        var documentsDirectory = myloveplistPath.objectAtIndex(0)
        var plistPath=documentsDirectory.stringByAppendingPathComponent("love")
        var array=NSMutableArray(contentsOfFile: GlobalVariables.getMyLovePlistPath())
        if array==nil{}
        a
        return plistPath
    }
}
