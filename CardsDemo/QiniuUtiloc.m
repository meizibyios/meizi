//
//  QiniuUtiloc.m
//  meizi
//
//  Created by xiaomo on 15/8/27.
//  Copyright (c) 2015年 Muhammad Bassio. All rights reserved.
//

#import "QiniuUtiloc.h"

#import <CommonCrypto/CommonDigest.h>
@implementation QiniuUtiloc

//字符sha1加密
+(NSString*)SHA1encode:(NSString*)value
{
    const char *cstr = [value cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:value.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}


//your app key = SHA1（你的应用ID + 'UZ' + 你的应用KEY +'UZ' + 当前时间毫秒数）.当前时间毫秒数
+(NSString *)getXAPICloudAppKey
{
        NSString * xappkey =@"";
        NSDate * date = [[NSDate alloc]init];
        NSString * time = [NSString stringWithFormat:@"%ld",(NSInteger)([date timeIntervalSince1970]*1000)];
        xappkey = [NSString stringWithFormat:@"%@.%@",[self SHA1encode:[NSString stringWithFormat:@"%sUZ%sUZ%@",APICLOUDID,APICLOUDKEY,time]],time];
    
    return xappkey;
}

+(UIImage *)getImageFromSD:(NSString *)key
{
    SDWebImageManager *manger=[SDWebImageManager sharedManager];
    UIImage *cacheUIImage=[[manger imageCache] imageFromDiskCacheForKey:key];
    if (cacheUIImage) {
        return cacheUIImage;
    }
    return  [UIImage imageNamed:@"AppIcon"];
}
@end
