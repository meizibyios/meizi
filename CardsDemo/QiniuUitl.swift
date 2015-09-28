//
//  QiniuUitl.swift
//  meizi
//
//  Created by xiaomo on 15/8/27.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//// 这可不是七牛  是apicloud

import Foundation
import Alamofire
import SwiftyJSON
class QiniuUtil {
    //your app key = SHA1（你的应用ID + 'UZ' + 你的应用KEY +'UZ' + 当前时间毫秒数）.当前时间毫秒数
    ////func getXAPICloudAppKey()->NSString{
     ////   var ID=""
    //    var apkKey=""
       // var date=NSDate()
    ///    var time="\(date.timeIntervalSince1970*1000)"
   //     var beforSha1="\(ID)UZ\()"
   //     var xappkey="\(QiniuUtiloc.SHA1encode("111")).1"
   //     return xappkey
  //  }
  //  +(NSString *)getXAPICloudAppKey
  //  {
   // NSString * xappkey = @"";
    
    //    NSString * ID = appAPiCloudID;
    //    NSString * appKey = appAPiCloudKEY;
    //    NSDate * date = [[NSDate alloc]init];
    //    NSString * time = [NSString stringWithFormat:@"%ld",(NSInteger)([date timeIntervalSince1970]*1000)];
    //    xappkey = [NSString stringWithFormat:@"%@.%@",[self SHA1encode:[NSString stringWithFormat:@"%@UZ%@UZ%@",ID,appKey,time]],time];
    
  //  return xappkey;
  //  }
    class func URL_APICLOUDMAIN()->String {
        return "https://d.apicloud.com/";
    }
    class func URL_INFO()->String {
        return "\(URL_APICLOUDMAIN())mcm/api/info/5604a9e0605f38b841d1e9d8"
    }
    class func URL_LOGIN()->String {
        return "\(URL_APICLOUDMAIN())mcm/api/user/login"
    }

    class func getApiHeaders()->[String:String!]{
        let headers=["X-APICloud-AppId":APICLOUD_ID,"X-APICloud-AppKey":QiniuUtiloc.getXAPICloudAppKey(),"Content-Type":"application/json"];
        return headers;
    }
    class func inView()->Bool {
        
        
        var parameters=["username":"asdfas","password":"123456"]
        Alamofire.request(.POST, QiniuUtil.URL_LOGIN(), headers: QiniuUtil.getApiHeaders() as? [String : String],parameters:parameters
            )
            .responseString { bs, a, Json, error in
                println(Json)
                
                //                let json=SwiftyJSON.JSON(Json!)
                
        }


      
       
        Alamofire.request(.GET, URL_INFO(), headers: getApiHeaders() as? [String : String],parameters:nil
            )
            .responseString { _, _, Json, error in
                println(Json)
                let json=SwiftyJSON.JSON(Json!)
               
        }
        return false;
    }
    
}