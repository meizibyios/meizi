//
//  QiniuUtiloc.h
//  meizi
//
//  Created by xiaomo on 15/8/27.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCHeader.h"
#define APICLOUDID "A6995690932101"
#define APICLOUDKEY "E4F6C0DA-0BF8-F1F0-D3A2-49348C054EAF"
@interface QiniuUtiloc : NSObject
+(NSString*)SHA1encode:(NSString*)value;
+(NSString *)getXAPICloudAppKey;
+(UIImage *)getImageFromSD:(NSString *)key;

@end
