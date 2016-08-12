//
//  PicItem.swift
//  meizi
//
//  Created by xiaomo on 15/8/26.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import Foundation
class PicItem :NSObject{
    var identify:String!// id  and  url
    var title:String!// title -_-
    var urlFrom:String!// where this pic from
    var picdescription:String!// dec of this pic
    var picFromUser:String!// who upload  this pic , nil is form network
    var like:String!// the number like this pic
    var dislike:String!// the number dislike
    var picSource:String="2"  //  love bizhi or api  or.... 0 default   1 api  2 lovebizhi
    init (identifyorurl:String){
        self.identify=identifyorurl
    }
    init(identifyorurl:String,title:String,urlFrom:String,description:String){
        self.identify=identifyorurl
        self.title=title
        self.urlFrom=urlFrom
        self.picdescription=description
    }
    class func loveBizhiUrl21920_1200 (url :String)->String{
        return url.stringByReplacingOccurrencesOfString("480", withString: "1920", options: [], range: nil).stringByReplacingOccurrencesOfString("300", withString: "1200", options: [], range: nil)
    }
    func getPicUrl1920_1200()->String
    {
        if(picSource=="2")
        {
            return PicItem.loveBizhiUrl21920_1200(identify)
        }
        return identify
    }
}