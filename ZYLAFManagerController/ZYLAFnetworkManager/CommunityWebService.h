//
//  CommunityWebService.h
//  ZHTarget
//
//  Created by  on 2017/9/20.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseWebService.h"

@interface CommunityWebService : BaseWebService

+ (instancetype)sharedInstance;

-(NSURLSessionDataTask *)getCommunityInfo:(NSString*)communityId completion:(void (^)(id responseObject,NSError * error))completion;
@end
