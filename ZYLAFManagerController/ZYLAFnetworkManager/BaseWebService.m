
//
//  BaseWebService.m
//  ZHTarget
//
//  Created by  on 2017/8/23.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "BaseWebService.h"


@implementation BaseWebService

static dispatch_group_t autoLoginGroup;
static BOOL autoLoginFlag;

-(void)startAutoLogin{
    autoLoginFlag = YES;
    autoLoginGroup = dispatch_group_create();
    dispatch_group_enter(autoLoginGroup);
}

-(void)endAutoLogin{
    autoLoginFlag = NO;
    dispatch_group_leave(autoLoginGroup);
}

- (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(id)parameters
                    completion:(void (^)(id ,NSError * ))completion{
    if(autoLoginFlag){
        dispatch_async(global_queue_default, ^{
            dispatch_time_t t = dispatch_time(DISPATCH_TIME_NOW, WebTimeoutInterval * NSEC_PER_SEC);
            dispatch_group_wait(autoLoginGroup, t);
            
            [self POST_p:URLString parameters:[self addBaseParameters:parameters] completion:completion];
        });
        return nil;
    }else{
        return [self POST_p:URLString parameters:[self addBaseParameters:parameters] completion:completion];
    }
}

-(NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))block progress:(void (^)(NSProgress * _Nonnull))uploadProgressBlock completion:(void (^)(id ,NSError * ))completion{
    
    parameters = [self addBaseParameters:parameters];
    return [super POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(block){
            block(formData);
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if(uploadProgressBlock){
            uploadProgressBlock(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if(completion){
            completion(result,error);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion){
            completion(nil,error);
        }
    }];
    
}


-(NSMutableDictionary*)addBaseParameters:(NSDictionary*)parameters{
    NSMutableDictionary *mdParameters;
    if(parameters){
        mdParameters  = [NSMutableDictionary dictionaryWithDictionary:parameters];
    }else{
        mdParameters = [NSMutableDictionary dictionary];
    }
    
    
    mdParameters[@"os"] = @"1";
   
    return mdParameters;
}

#pragma mark private Method

- (NSURLSessionDataTask *)POST_p:(NSString *)URLString
                      parameters:(id)parameters
                      completion:(void (^)(id ,NSError * ))completion{
    
    
    
    return [super POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error;
        id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        if(completion){
            completion(result,error);
        }
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(completion){
            completion(nil,error);
        }
    }];
}




@end
