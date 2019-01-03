//
//  CommunityWebService.m
//  ZHTarget
//
//  Created by  on 2017/9/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "CommunityWebService.h"


@implementation CommunityWebService

+ (instancetype)sharedInstance
{
    static CommunityWebService *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
        _instance.requestSerializer = [AFHTTPRequestSerializer serializer];
        _instance.responseSerializer = [AFHTTPResponseSerializer serializer];
        _instance.requestSerializer.timeoutInterval = WebTimeoutInterval;
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        [securityPolicy setValidatesDomainName:NO];
        [_instance setSecurityPolicy:securityPolicy];
    });
    return _instance;
}


+ (id)allocWithZone:(struct _NSZone *)zone{
    return [CommunityWebService sharedInstance];
}

-(NSURLSessionDataTask *)getCommunityInfo:(NSString *)communityId completion:(void (^)(id, NSError *))completion{
    NSString *url = @"communityInfo/getCommunityInfo";
    NSDictionary *parameters = @{@"communityId":communityId ? communityId : @""
                                 };
    return [self POST:url parameters:parameters completion:completion];
}



@end
