//
//  ViewController.m
//  ZYLAFManagerController
//
//  Created by gxd on 2018/12/29.
//  Copyright © 2018年 zyl. All rights reserved.
//

#import "ViewController.h"
#import "CommunityWebService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //实际请求方法
    [[CommunityWebService sharedInstance] getCommunityInfo:@"123" completion:^(id responseObject, NSError *error) {
        
    }];
}


@end
