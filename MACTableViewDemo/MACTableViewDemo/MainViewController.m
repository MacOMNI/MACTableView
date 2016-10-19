//
//  MainViewController.m
//  MACTableViewDemo
//
//  Created by MacKun on 16/10/18.
//  Copyright © 2016年 com.mackun. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewCell.h"
#import "DetailViewController.h"
#import "UIColor+Hexadecimal.h"
#import "DetailModel.h"
#import "Application.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray<DetailModel*> *dataArr;
@property (nonatomic, strong) NSMutableArray *applications;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initData];
    // Do any additional setup after loading the view from its nib.
}
-(void)initUI{
    self.title            = @"MACTableView";
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    _tableView.rowHeight  = 60.0f;
    [_tableView registerNib:[UINib nibWithNibName:@"MainViewCell" bundle:nil] forCellReuseIdentifier:@"mainViewCell"];
}
-(void)initData{
    _dataArr = [NSMutableArray new];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"applications" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *objects = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions|NSJSONWritingPrettyPrinted error:nil] mutableCopy];
    
    self.applications = [NSMutableArray new];
    
    for (NSDictionary *dictionary in objects) {
        Application *app = [[Application alloc] initWithDictionary:dictionary];
        [self.applications addObject:app];
    }


}
#pragma  mark tableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.applications.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainViewCell"];
    Application *app = [self.applications objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = app.displayName;
    cell.descriptionLabel.text = app.developerName;
    UIImage *image = [UIImage imageNamed:app.iconName];
    cell.imgView.image = image;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    Application *application = [self.applications objectAtIndex:indexPath.row];
    detailVC.application = application;
    detailVC.emptyTitle  = [self getEmptyTitle:application];
    detailVC.descriptionTitle = [self getEmptyDescription:application];
    detailVC.emptyColor = [self getEmptyColor:application];
    detailVC.emptyImage = [self getEmptyImage:application];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(UIColor *)getEmptyColor:(Application *)application{
    switch (application.type) {
        case ApplicationType500px:      return [UIColor blackColor];
        case ApplicationTypeAirbnb:     return [UIColor whiteColor];
        case ApplicationTypeDropbox:    return [UIColor colorWithHex:@"f0f3f5"];
        case ApplicationTypeFacebook:   return [UIColor colorWithHex:@"eceef7"];
        case ApplicationTypeFancy:      return [UIColor colorWithHex:@"f0f0f0"];
        case ApplicationTypeFoursquare: return [UIColor colorWithHex:@"fcfcfa"];
        case ApplicationTypeInstagram:  return [UIColor whiteColor];
        case ApplicationTypeKickstarter:return [UIColor colorWithHex:@"f7fafa"];
        case ApplicationTypePath:       return [UIColor colorWithHex:@"726d67"];
        case ApplicationTypePinterest:  return [UIColor colorWithHex:@"e1e1e1"];
        case ApplicationTypeSlack:      return [UIColor whiteColor];
        case ApplicationTypeTumblr:     return [UIColor colorWithHex:@"34465c"];
        case ApplicationTypeTwitter:    return [UIColor colorWithHex:@"f5f8fa"];
        case ApplicationTypeVesper:     return [UIColor colorWithHex:@"f8f8f8"];
        case ApplicationTypeVideos:     return [UIColor blackColor];
        case ApplicationTypeWhatsapp:   return [UIColor colorWithHex:@"f2f2f2"];
        default:                        return nil;
    }

}
-(UIImage *)getEmptyImage:(Application*) application{
    NSString *imageName = [[[NSString stringWithFormat:@"placeholder_%@", application.displayName] lowercaseString]
                           stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    
    return [UIImage imageNamed:imageName];
}
-(NSAttributedString *)getEmptyTitle:(Application *)application{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    switch (application.type) {
        case ApplicationType500px:
        {
            text = @"No Photos";
            font = [UIFont boldSystemFontOfSize:17.0];
            textColor = [UIColor colorWithHex:@"545454"];
            break;
        }
        case ApplicationTypeAirbnb:
        {
            text = @"No Messages";
            font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0];
            textColor = [UIColor colorWithHex:@"c9c9c9"];
            break;
        }
        case ApplicationTypeCamera:
        {
            text = @"Please Allow Photo Access";
            font = [UIFont boldSystemFontOfSize:18.0];
            textColor = [UIColor colorWithHex:@"5f6978"];
            break;
        }
        case ApplicationTypeDropbox:
        {
            text = @"Star Your Favorite Files";
            font = [UIFont boldSystemFontOfSize:17.0];
            textColor = [UIColor colorWithHex:@"25282b"];
            break;
        }
        case ApplicationTypeFacebook:
        {
            text = @"No friends to show.";
            font = [UIFont boldSystemFontOfSize:22.0];
            textColor = [UIColor colorWithHex:@"acafbd"];
            
            NSShadow *shadow = [NSShadow new];
            shadow.shadowColor = [UIColor whiteColor];
            shadow.shadowOffset = CGSizeMake(0.0, 1.0);
            [attributes setObject:shadow forKey:NSShadowAttributeName];
            break;
        }
        case ApplicationTypeFancy:
        {
            text = @"No Owns yet";
            font = [UIFont boldSystemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"494c53"];
            break;
        }
        case ApplicationTypeiCloud:
        {
            text = @"iCloud Photo Sharing";
            break;
        }
        case ApplicationTypeInstagram:
        {
            text = @"Instagram Direct";
            font = [UIFont fontWithName:@"HelveticaNeue-Light" size:26.0];
            textColor = [UIColor colorWithHex:@"444444"];
            break;
        }
        case ApplicationTypeiTunesConnect:
        {
            text = @"No Favorites";
            font = [UIFont systemFontOfSize:22.0];
            break;
        }
        case ApplicationTypeKickstarter:
        {
            text = @"Activity empty";
            font = [UIFont boldSystemFontOfSize:16.0];
            textColor = [UIColor colorWithHex:@"828587"];
            [attributes setObject:@(-0.10) forKey:NSKernAttributeName];
            break;
        }
        case ApplicationTypePath:
        {
            text = @"Message Your Friends";
            font = [UIFont boldSystemFontOfSize:14.0];
            textColor = [UIColor whiteColor];
            break;
        }
        case ApplicationTypePinterest:
        {
            text = @"No boards to display";
            font = [UIFont boldSystemFontOfSize:18.0];
            textColor = [UIColor colorWithHex:@"666666"];
            break;
        }
        case ApplicationTypePhotos:
        {
            text = @"No Photos or Videos";
            break;
        }
        case ApplicationTypePodcasts:
        {
            text = @"No Podcasts";
            break;
        }
        case ApplicationTypeRemote:
        {
            text = @"Cannot Connect to a Local Network";
            font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
            textColor = [UIColor colorWithHex:@"555555"];
            break;
        }
        case ApplicationTypeTumblr:
        {
            text = @"This is your Dashboard.";
            font = [UIFont boldSystemFontOfSize:18.0];
            textColor = [UIColor colorWithHex:@"aab6c4"];
            break;
        }
        case ApplicationTypeTwitter:
        {
            text = @"No lists";
            font = [UIFont boldSystemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"292f33"];
            break;
        }
        case ApplicationTypeVesper:
        {
            text = @"No Notes";
            font = [UIFont fontWithName:@"IdealSans-Book-Pro" size:16.0];
            textColor = [UIColor colorWithHex:@"d9dce1"];
            break;
        }
        case ApplicationTypeVideos:
        {
            text = @"AirPlay";
            font = [UIFont systemFontOfSize:17.0];
            textColor = [UIColor colorWithHex:@"414141"];
            break;
        }
        case ApplicationTypeVine:
        {
            text = @"Welcome to VMs";
            font = [UIFont boldSystemFontOfSize:22.0];
            textColor = [UIColor colorWithHex:@"595959"];
            [attributes setObject:@(0.45) forKey:NSKernAttributeName];
            break;
        }
        case ApplicationTypeWhatsapp:
        {
            text = @"No Media";
            font = [UIFont systemFontOfSize:20.0];
            textColor = [UIColor colorWithHex:@"808080"];
            break;
        }
        case ApplicationTypeWWDC:
        {
            text = @"No Favorites";
            font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
            textColor = [UIColor colorWithHex:@"b9b9b9"];
            break;
        }
        default:
            return nil;
    }
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];

}

-(NSAttributedString *)getEmptyDescription:(Application *)application{
    NSString *text = nil;
    UIFont *font = nil;
    UIColor *textColor = nil;
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    switch (application.type) {
        case ApplicationType500px:
        {
            text = @"Get started by uploading a photo.";
            font = [UIFont boldSystemFontOfSize:15.0];
            textColor = [UIColor colorWithHex:@"545454"];
            break;
        }
        case ApplicationTypeAirbnb:
        {
            text = @"When you have messages, you’ll see them here.";
            font = [UIFont systemFontOfSize:13.0];
            textColor = [UIColor colorWithHex:@"cfcfcf"];
            paragraph.lineSpacing = 4.0;
            break;
        }
        case ApplicationTypeAppstore:
        {
            text = @"There are no results for “wwdc2014”.";
            font = [UIFont systemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"333333"];
            break;
        }
        case ApplicationTypeCamera:
        {
            text = @"This allows you to share photos from your library and save photos to your camera roll.";
            font = [UIFont systemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"5f6978"];
            break;
        }
        case ApplicationTypeDropbox:
        {
            text = @"Favorites are saved for offline access.";
            font = [UIFont systemFontOfSize:14.5];
            textColor = [UIColor colorWithHex:@"7b8994"];
            break;
        }
        case ApplicationTypeFancy:
        {
            text = @"Tap Add to List and add things to Owns";
            font = [UIFont systemFontOfSize:13.0];
            textColor = [UIColor colorWithHex:@"7a7d83"];
            break;
        }
        case ApplicationTypeFoursquare:
        {
            text = @"Nobody has liked or commented on your check-ins yet.";
            font = [UIFont boldSystemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"cecbc6"];
            break;
        }
        case ApplicationTypeiCloud:
        {
            text = @"Share photos and videos with just the people you choose, and let them add photos, videos, and comments.";
            paragraph.lineSpacing = 2.0;
            break;
        }
        case ApplicationTypeInstagram:
        {
            text = @"Send photos and videos directly to your friends. Only the people you send to can see these posts.";
            font = [UIFont systemFontOfSize:16.0];
            textColor = [UIColor colorWithHex:@"444444"];
            paragraph.lineSpacing = 4.0;
            break;
        }
        case ApplicationTypeiTunesConnect:
        {
            text = @"To add a favorite, tap the star icon next to an App's name.";
            font = [UIFont systemFontOfSize:14.0];
            break;
        }
        case ApplicationTypeKickstarter:
        {
            text = @"When you back a project or follow a friend, their activity will show up here.";
            font = [UIFont systemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"828587"];
            break;
        }
        case ApplicationTypePath:
        {
            text = @"Send a message or create a group.";
            font = [UIFont systemFontOfSize:14.0];
            textColor = [UIColor colorWithHex:@"a6978d"];
            break;
        }
        case ApplicationTypePhotos:
        {
            text = @"You can sync photos and videos onto your iPhone using iTunes.";
            break;
        }
        case ApplicationTypePodcasts:
        {
            text = @"You can subscribe to podcasts in Top Charts or Featured.";
            break;
        }
        case ApplicationTypeRemote:
        {
            text = @"You must connect to a Wi-Fi network to control iTunes or Apple TV";
            font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:11.75];
            textColor = [UIColor colorWithHex:@"555555"];
            break;
        }
        case ApplicationTypeSafari:
        {
            text = @"Safari cannot open the page because your iPhone is not connected to the Internet.";
            textColor = [UIColor colorWithHex:@"7d7f7f"];
            paragraph.lineSpacing = 2.0;
            break;
        }
        case ApplicationTypeSkype:
        {
            text = @"Keep all your favorite people together, add favorites.";
            font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.75];
            textColor = [UIColor colorWithHex:@"a6c3d1"];
            paragraph.lineSpacing = 3.0;
            break;
        }
        case ApplicationTypeSlack:
        {
            text = @"You don't have any recent mentions";
            font = [UIFont fontWithName:@"Lato-Regular" size:19.0];
            textColor = [UIColor colorWithHex:@"d7d7d7"];
            break;
        }
        case ApplicationTypeTumblr:
        {
            text = @"When you follow some blogs, their latest posts will show up here!";
            font = [UIFont systemFontOfSize:17.0];
            textColor = [UIColor colorWithHex:@"828e9c"];
            break;
        }
        case ApplicationTypeTwitter:
        {
            text = @"You aren’t subscribed to any lists yet.";
            font = [UIFont systemFontOfSize:12.0];
            textColor = [UIColor colorWithHex:@"8899a6"];
            break;
        }
        case ApplicationTypeVideos:
        {
            text = @"This video is playing on “Apple TV”.";
            font = [UIFont systemFontOfSize:12.0];
            textColor = [UIColor colorWithHex:@"737373"];
            break;
        }
        case ApplicationTypeVine:
        {
            text = @"This is where your private conversations will live";
            font = [UIFont systemFontOfSize:17.0];
            textColor = [UIColor colorWithHex:@"a6a6a6"];
            break;
        }
        case ApplicationTypeWhatsapp:
        {
            text = @"You can exchange media with Ignacio by tapping on the Arrow Up icon in the conversation screen.";
            font = [UIFont systemFontOfSize:15.0];
            textColor = [UIColor colorWithHex:@"989898"];
            break;
        }
        case ApplicationTypeWWDC:
        {
            text = @"Favorites are only available to Registered Apple Developers.";
            font = [UIFont systemFontOfSize:16.0];
            textColor = [UIColor colorWithHex:@"b9b9b9"];
            break;
        }
        default:
            return nil;
    }
    
    if (!text) {
        return nil;
    }
    
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    
    switch (application.type) {
        case ApplicationTypeSkype:
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"00adf1"] range:[attributedString.string rangeOfString:@"add favorites"]];
            break;
            
        default:
            break;
    }
    
    return attributedString;

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
