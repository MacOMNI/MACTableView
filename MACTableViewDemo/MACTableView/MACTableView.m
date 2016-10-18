//
//  MACTableView.m
//  WeSchoolTeacher
//
//  Created by MacKun on 16/3/1.
//  Copyright © 2016年 solloun. All rights reserved.
//

#import "MACTableView.h"
#import "MACRefreshHeader.h"
#import "MJRefreshAutoFooter.h"
#import "UIScrollView+EmptyDataSet.h"

@interface MACTableView()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
/**是否第一次加载就展示空白页 默认为YES*/
@property(nonatomic,assign)BOOL firstShowEmpty;
/**  当前访问的page 下标*/
@property (nonatomic,assign) NSInteger page;
@end

@implementation MACTableView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    if (self) {
        [self initUI];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.firstShowEmpty = NO;
    }
    return self;
}
-(void)initUI{
    self.tableFooterView                = [UIView new];
    self.macCanLoadState                = MACCanLoadAll;
    self.emptyTitle                     = @"咋没数据呢,刷新试试~~";
    self.emptySubtitle                  = @"您的数据被程序猿搬走咯~~";
    self.emptyImage                     = nil;
    self.emptyColor                     = [UIColor whiteColor];
    self.firstShowEmpty                 = YES;
    self.showEmpty                      = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator   = NO;
    
    self.emptyDataSetDelegate           = self;
    self.emptyDataSetSource             = self;
    
    self.page                           = 0;

}
-(void)setMacTableViewDelegate:(id<MACTableViewDelegate>)macTableViewDelegate{
    _macTableViewDelegate = macTableViewDelegate;
    self.dataSource       = (id<UITableViewDataSource>)macTableViewDelegate;
    self.delegate         = (id<UITableViewDelegate>)macTableViewDelegate;
}
-(void)setMacCanLoadState:(MACCanLoadState)macCanLoadState{
    _macCanLoadState = macCanLoadState;
    switch (_macCanLoadState) {
        case MACCanLoadAll:{
            self.mj_header = [MACRefreshHeader headerWithRefreshingBlock:^{
                [self  refreshData];
            }];
            self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                
                if (_macTableViewDelegate && [_macTableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
                    [_macTableViewDelegate loadDataRefreshOrPull:MACPulling];
                }
            }];
            self.mj_header.multipleTouchEnabled = NO;
            self.mj_footer.multipleTouchEnabled = NO;

        }break;
        case MACCanLoadRefresh:{
            self.mj_header = [MACRefreshHeader headerWithRefreshingBlock:^{
                [self refreshData];
            }];
            self.mj_header.multipleTouchEnabled = NO;
            self.mj_footer = nil;
        }break;
        case MACCanLoadNone:{
            self.mj_header = nil;
            self.mj_footer = nil;
        }break;
    }
}
-(void)beginLoading{
    [self.mj_header beginRefreshing];
}
-(void)endLoading{
    if([self.mj_header isRefreshing])
    [self.mj_header endRefreshing];
    if ([self.mj_footer isRefreshing])
    [self.mj_footer endRefreshing];
    [self reloadData];
}
-(void)noMoreData{
    if ([self.mj_footer isRefreshing])
        [self.mj_footer endRefreshingWithNoMoreData];
}
-(void)refreshData{
    if (self.mj_footer.state == MJRefreshStateNoMoreData) {
        [self.mj_footer resetNoMoreData];
    }
    if (_macTableViewDelegate && [_macTableViewDelegate respondsToSelector:@selector(loadDataRefreshOrPull:)]) {
        self.page = 0;
        [_macTableViewDelegate loadDataRefreshOrPull:MACRefreshing];
    }
}
-(NSNumber *)getCurrentPage{
    return [NSNumber numberWithInteger:++self.page];
}
#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text =self.emptyTitle;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    NSString *text = self.emptySubtitle;
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyImage;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    return self.emptyColor;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return -20.0f;
}
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
    return 0.0f;
}
#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView{
    
    if (_firstShowEmpty)  return _firstShowEmpty = NO;

    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView{
    return YES;
}
- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath: @"transform"];
    
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0)];
    
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    
    return animation;
}


@end
