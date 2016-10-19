# MACTableView
##Projects using this library

对 UITableView 空白页文字提示、空白页图片、上拉下拉事件等进行了高度封装，使用简单高效，并命名为MACTableView。

![GIF 1](https://github.com/azheng51714/MACTableView/blob/master/Photos/fvyO81OO7L.gif);
![GIF 2](https://github.com/azheng51714/MACTableView/blob/master/Photos/hmD0r7fU0J.gif);
![GIF 3](https://github.com/azheng51714/MACTableView/blob/master/Photos/MACTableView.png);
### Features
* 支持 多种多种空白样式：包括是否显示主标题、副标题、空白图以及是否支持上拉下拉代理事件等；
* 基于 MJRefresh & DZNEmptyDataSet 集成设计；
* 支持 Storyboard & Xib;
* 支持 iOS 6 及以上;
* 支持 iPhone & iPad.

## Installation

* 暂未支持 cocoapod

### Import
导入相关头文件
```objc
#import "MACTableView.h"
```

## How to use
* First Step 初始化 MACTableView ；

```objc
@interface ViewController ()<MACTableViewDelegate>{

}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // self.tableView =  [[MACTableView alloc] initWithFrame:self.view.bounds]; 
    self.tableView.macTableViewDelegate = self;
}
```
* Second Step 设置 MACTableView属性 并开始加载；

```objc
-(void)setUp{
    _tableView.emptyImage = self.emptyImage;
    _tableView.emptyColor = self.emptyColor;
    _tableView.emptyAtrtibutedTitle = self.emptyTitle;
    _tableView.emptyAtrtibutedSubtitle = self.descriptionTitle;
    [_tableView beginLoading];
  } 
```

* Final Step 处理上拉下拉代理事件

```objc
#pragma mark MACTableViewDelegate
-(void)loadDataRefreshOrPull:(MACRefreshState)state{
   if(state == MACRefreshing){
     //do something
   }else {
     // do other thing
   }
  //异步(网络访问)请求后执行 [self.tableView endLoading] 结束刷新
}

```

### MACTableView

这里对相关的参数变量、枚举类型、代理以及执行方法进行了详细的说明，您只需要根据具体情况设置相关属性，执行相应操作即可。
```objc
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MACRefreshState) {
    
    MACRefreshing = 0, /** 下拉刷新的状态 */
    MACPulling,        /** pull 加载更多刷新中的状态 */
};

typedef NS_ENUM(NSInteger,MACCanLoadState){
    
    MACCanLoadNone = 0,/**不支持下拉和加载更多*/
    MACCanLoadRefresh, /**只支持下拉刷新*/
    MACCanLoadAll,     /** 同时支持下拉和加载更多*/
};

@protocol MACTableViewDelegate <NSObject>

@optional

/**@param state MACRefreshing 下拉刷新 MACPulling 为 Pull 加载更多*/
-(void)loadDataRefreshOrPull:(MACRefreshState)state;

@end

@interface MACTableView : UITableView<NSCoding>

@property (nonatomic,weak) id<MACTableViewDelegate> macTableViewDelegate;//MACTableView delegate

/** 是否展示空白页 默认为YES*/
@property(nonatomic,assign,getter = isShowEmpty)BOOL showEmpty;
/** MACTableView 加载支持，默认同时支持下拉和加载更多*/
@property (nonatomic,assign) IBInspectable MACCanLoadState macCanLoadState;
/**空白页的标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptyTitle;
/**  空白页的副标题 默认为 “" 为空,不显示*/
@property(nonatomic,copy) IBInspectable NSString *emptySubtitle;
/**  空白页展位图名称 默认为 nil,不显示*/
@property(nonatomic,strong) IBInspectable UIImage *emptyImage;
/**  空白页背景颜色,默认白色*/
@property(nonatomic,strong) IBInspectable UIColor *emptyColor;

/**空白页的标题 默认为 nil ,不显示*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedTitle;
/**  空白页的副标题 默认为 nil,不显示*/
@property(nonatomic,copy) IBInspectable NSAttributedString *emptyAtrtibutedSubtitle;

/** 获取当下访问接口Page下标 默认从1开始 以来代替控制器计算Page*/
-(NSNumber *)getCurrentPage;
/** 开始加载*/
-(void)beginLoading;
/**结束加载，并刷新数据*/
-(void)endLoading;
/**提示无更多数据*/
-(void)noMoreData;
@end

```
## License
(The MIT License)


