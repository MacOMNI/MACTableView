//
//  UIViewController+BackButtonItemTitle.h
//

#import <UIKit/UIKit.h>

@protocol BackButtonItemTitleProtocol <NSObject>

@optional
- (NSString *)navigationItemBackBarButtonTitle; //The length of the text is limited, otherwise it will be set to "Back"

@end

@interface UIViewController (BackButtonItemTitle) <BackButtonItemTitleProtocol>

@end
