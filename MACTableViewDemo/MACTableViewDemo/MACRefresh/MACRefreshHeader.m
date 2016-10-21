//
//  MACRefreshHeader.m
//  WeiSchoolTeacher
//
//  Created by MacKun on 16/1/11.
//  Copyright © 2016年 MacKun. All rights reserved.
//

#import "MACRefreshHeader.h"

@implementation MACRefreshHeader

-(void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 隐藏时间
    //self.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏刷新状态
    //self.stateLabel.hidden = YES;
}

+ (void)load{
    NSLog(@"----------重写 load 方法， 注册 MACRefreshGifHeader,即可实现自定义RefreshHeader,无需其他操作----------------");
    [super registerMACRefresh];
}
@end
