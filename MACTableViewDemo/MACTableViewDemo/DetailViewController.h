//
//  DetailViewController.h
//  MACTableViewDemo
//
//  Created by MacKun on 16/10/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MACTableView.h"
#import "Application.h"
@interface DetailViewController : UIViewController

@property (nonatomic, strong) Application *application;

@property (nonatomic,strong) UIColor *emptyColor;

@property (nonatomic,strong) UIImage *emptyImage;

@property (nonatomic,copy) NSAttributedString *emptyTitle;

@property (nonatomic,copy) NSAttributedString *descriptionTitle;


@property (weak, nonatomic) IBOutlet MACTableView *tableView;
@end
