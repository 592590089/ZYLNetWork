//
//  BaseWebService.h
//  ZHTarget
//
//  Created by  on 2017/8/23.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseWebService : AFHTTPSessionManager


- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    completion:(void (^)(id responseObject,NSError *error))completion;

- (NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters    constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                     progress:(void (^)(NSProgress *uploadProgress))uploadProgress
                   completion:(void (^)(id responseObject,NSError *error))completion;

-(NSMutableDictionary*)addBaseParameters:(NSDictionary*)parameters;

-(void)startAutoLogin;

-(void)endAutoLogin;

@end
