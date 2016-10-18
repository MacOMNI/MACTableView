//
//  MainViewCell.h
//  MACTableViewDemo
//
//  Created by MacKun on 16/10/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end
