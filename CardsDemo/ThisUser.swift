//
//  User.swift
//  meizi
//
//  Created by xmw on 15/9/16.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import UIKit

class ThisUser: NSObject {
    var userType="0"// 用户登录的类型  0本地用户 1或者微信用户
    var userNmae=""
    //**系统返回的id**//
    var userId=""
    //** 用户 微信 key*//
    var userWChartId=""
    var userPSW=""
    override init() {
        
    }
    
    init(userNmae:String,userId:String ,userWChartId:String,userType:String,userPSW:String) {
        self.userNmae=userNmae
        self.userId=userId
        self.userWChartId=userWChartId
        self.userType=userType
        self.userPSW=userPSW
    }
    class getUserName {
        
    }
    //***dic 2 object**//
    class func getUserFromDic(dic:NSDictionary)->ThisUser{
        var user = ThisUser()
        var temp = dic.objectForKey("userNmae") as!String
        if !temp.isEmpty
        {
            user.userNmae=temp
        }
        temp = dic.objectForKey("userId") as!String
        if !temp.isEmpty
        {
            user.userId=temp
        }
        temp = dic.objectForKey("userType") as!String
        if !temp.isEmpty
        {
            user.userType=temp
        }
        temp = dic.objectForKey("userWChartId") as!String
        if !temp.isEmpty
        {
            user.userWChartId=temp
        }

        return user ;
    }
    
}
