//
//  QiniuUtiloc.h
//  meizi
//
//  Created by xiaomo on 15/8/27.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiniuUtiloc : NSObject
+(NSString*)SHA1encode:(NSString*)value;
+(NSString *)getXAPICloudAppKey;
@end
