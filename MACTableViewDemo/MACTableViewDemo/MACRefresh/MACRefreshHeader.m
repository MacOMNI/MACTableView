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
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:@"icon_refresh_1"];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i <= 3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"icon_refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    
    // Hide the status
   // self.stateLabel.hidden = YES;
}

+ (void)load{
    NSLog(@"----------重写 load 方法， 注册 MACRefreshGifHeader,即可实现自定义RefreshHeader,无需其他操作----------------");
    [super registerMACRefresh];
}
@end
