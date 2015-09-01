//
//  PicItem.swift
//  meizi
//
//  Created by xiaomo on 15/8/26.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

import Foundation
class PicItem {
    var identify:String!// id  and  url
    var title:String!// title -_-
    var urlFrom:String!// where this pic from
    var description:String!// dec of this pic
    var picFromUser:String!// who upload  this pic , nil is form network
    var like:String!// the number like this pic
    var dislike:String!// the number dislike
    
    init (identifyorurl:String){
        self.identify=identifyorurl
    }
    init(identifyorurl:String,title:String,urlFrom:String,description:String){
        self.identify=identifyorurl
        self.title=title
        self.urlFrom=urlFrom
        self.description=description
    }
}