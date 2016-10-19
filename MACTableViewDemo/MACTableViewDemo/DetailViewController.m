//
//  DetailViewController.m
//  MACTableViewDemo
//
//  Created by MacKun on 16/10/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "DetailViewController.h"
#import "UIColor+Hexadecimal.h"
@interface DetailViewController ()<MACTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArr;
}

@end

@implementation DetailViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self configureNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}

-(void)initUI{
    _tableView.macTableViewDelegate = self;
    _tableView.dataSource = self;
    _tableView.delegate = self;
}
-(void)initData{
    //[_tableView reloadData];
    _dataArr = [NSMutableArray arrayWithArray:@[@"张三",@"李四",@"王五",@"赵六",@"冯七",@"刘八"]];
    _tableView.emptyImage = self.emptyImage;
    _tableView.emptyColor = self.emptyColor;
    _tableView.emptyAtrtibutedTitle = self.emptyTitle;
    _tableView.emptyAtrtibutedSubtitle = self.descriptionTitle;
    [_tableView beginLoading];
}

#pragma mark macTableViewDelegate
-(void)loadDataRefreshOrPull:(MACRefreshState)state{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_dataArr.count) {
            [_dataArr removeAllObjects];
        }else _dataArr = [NSMutableArray arrayWithArray:@[@"张三",@"李四",@"王五",@"赵六",@"冯七",@"刘八"]];
       
        [_tableView endLoading];
        
    });
}
#pragma  mark tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;// _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell %ld",indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - Configuration and Event Methods

- (void)configureNavigationBar
{
    UIColor *barColor = nil;
    UIColor *tintColor = nil;
    UIStatusBarStyle barstyle = UIStatusBarStyleDefault;
    
    self.navigationController.navigationBar.titleTextAttributes = nil;
    
    switch (self.application.type) {
        case ApplicationType500px:
        {
            barColor = [UIColor colorWithHex:@"242424"];
            tintColor = [UIColor colorWithHex:@"d7d7d7"];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeAirbnb:
        {
            barColor = [UIColor colorWithHex:@"f8f8f8"];
            tintColor = [UIColor colorWithHex:@"08aeff"];
            break;
        }
        case ApplicationTypeCamera:
        {
            barColor = [UIColor colorWithHex:@"595959"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: tintColor};
            break;
        }
        case ApplicationTypeDropbox:
        {
            barColor = [UIColor whiteColor];
            tintColor = [UIColor colorWithHex:@"007ee5"];
            break;
        }
        case ApplicationTypeFacebook:
        {
            barColor = [UIColor colorWithHex:@"506da8"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeFancy:
        {
            barColor = [UIColor colorWithHex:@"353b49"];
            tintColor = [UIColor colorWithHex:@"c4c7cb"];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeFoursquare:
        {
            barColor = [UIColor colorWithHex:@"00aeef"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeInstagram:
        {
            barColor = [UIColor colorWithHex:@"2e5e86"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeKickstarter:
        {
            barColor = [UIColor colorWithHex:@"f7f8f8"];
            tintColor = [UIColor colorWithHex:@"2bde73"];
            break;
        }
        case ApplicationTypePath:
        {
            barColor = [UIColor colorWithHex:@"544f49"];
            tintColor = [UIColor colorWithHex:@"fffff2"];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypePinterest:
        {
            barColor = [UIColor colorWithHex:@"f4f4f4"];
            tintColor = [UIColor colorWithHex:@"cb2027"];
            break;
        }
        case ApplicationTypeSlack:
        {
            barColor = [UIColor colorWithHex:@"f4f5f6"];
            tintColor = [UIColor colorWithHex:@"3eba92"];
            break;
        }
        case ApplicationTypeSkype:
        {
            barColor = [UIColor colorWithHex:@"00aff0"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeTumblr:
        {
            barColor = [UIColor colorWithHex:@"2e3e53"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeTwitter:
        {
            barColor = [UIColor colorWithHex:@"58aef0"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeVesper:
        {
            barColor = [UIColor colorWithHex:@"5e7d9a"];
            tintColor = [UIColor colorWithHex:@"f8f8f8"];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeVideos:
        {
            barColor = [UIColor colorWithHex:@"4a4b4d"];
            tintColor = [UIColor blackColor];
            break;
        }
        case ApplicationTypeVine:
        {
            barColor = [UIColor colorWithHex:@"00bf8f"];
            tintColor = [UIColor whiteColor];
            barstyle = UIStatusBarStyleLightContent;
            break;
        }
        case ApplicationTypeWWDC:
        {
            tintColor = [UIColor colorWithHex:@"fc6246"];
            break;
        }
        default:
            barColor = [UIColor colorWithHex:@"f8f8f8"];
            tintColor = [UIApplication sharedApplication].keyWindow.tintColor;
            break;
    }
    
    UIImage *logo = [UIImage imageNamed:[NSString stringWithFormat:@"logo_%@", [self.application.displayName lowercaseString]]];
    if (logo) {
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logo];
    }
    else {
        self.navigationItem.titleView = nil;
        self.navigationItem.title = self.application.displayName;
    }
    
    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationController.navigationBar.tintColor = tintColor;
    
    [[UIApplication sharedApplication] setStatusBarStyle:barstyle animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
