//
//  IpChecker.m
//  CheckIp
//
//  Created by liuminguang on 15/7/29.
//  Copyright (c) 2015年 kkk. All rights reserved.
//

#import "IpChecker.h"
#import "CheckReach.h"

static IpChecker *checker;
//字符串为空设置为@“”
#define STRING_SAFELY(__VALUE) (((__VALUE) == nil) ? @"" : (__VALUE))

@implementation IpChecker

#pragma  mark--收集ip
+(void)checkIp
{
    CheckReach *r =[CheckReach reachabilityForInternetConnection];
    if([r currentReachabilityStatus]== NotReachable)
        return ;
    //ip1
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
        //匹配ip地址的正则表达式
        NSString *regexStr = @"\\b(?:\\d{1,3}\\.){3}\\d{1,3}\\b";
        NSString *ip1 = [IpChecker getIp:@"http://www.ip38.com/" withRegexString:regexStr];
        NSLog(@"当前的ip 地址是 %@",ip1);
    });
}

+(NSString *)getIp :(NSString *)urlStr withRegexString :(NSString *)regexStr
{
    // 如果网址中存在中文,进行URLEncode
    NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // 2.构建网络URL对象, NSURL
    NSURL *url = [NSURL URLWithString:newUrlStr];
    if (url == nil) {
        return @"";
    }
    // 3.创建网络请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    // 创建同步链接
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if(data==nil)
        return @"";
    //返回静态网页字符串
    NSString *responseStr = STRING_SAFELY([[NSString alloc] initWithData:data encoding:0x80000632]);
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:&error];
    NSString *result = @"";
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:responseStr options:0 range:NSMakeRange(0, [responseStr length])];
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString当中截取数据
            result= STRING_SAFELY([responseStr substringWithRange:resultRange]);
            //输出结果
        }
    }
    return result;
}


@end
