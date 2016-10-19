//
//  DetailViewController.m
//  MACTableViewDemo
//
//  Created by MacKun on 16/10/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()<MACTableViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataArr;
}

@end

@implementation DetailViewController

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
    _dataArr = [NSMutableArray new];
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
