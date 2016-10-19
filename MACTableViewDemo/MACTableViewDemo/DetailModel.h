//
//  DetailModel.h
//  MACTableViewDemo
//
//  Created by MacKun on 16/10/19.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailModel : NSObject

@property (copy, nonatomic)  NSString *display_name;

@property (copy, nonatomic)  NSString *developer_name;

@property (copy, nonatomic)  NSString *identifier;

@property (copy, nonatomic)  NSString *barColor;

@property (copy, nonatomic)  NSString *tintColor;

@property (nonatomic,assign) NSInteger reloadButton;

@end
