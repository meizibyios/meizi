//
//  QiniuUtiloc.h
//  meizi
//
//  Created by xiaomo on 15/8/27.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//
//// 这可不是七牛  是apicloud
#import <Foundation/Foundation.h>
#import "OCHeader.h"
#define APICLOUD_ID @"A6995690932101"
@interface QiniuUtiloc : NSObject
+(NSString*)SHA1encode:(NSString*)value;
+(NSString *)getXAPICloudAppKey;
+(UIImage *)getImageFromSD:(NSString *)key;
@end
