#import <UIKit/UIKit.h>

@class LjsViewController;

@interface LjsAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LjsViewController *viewController;

@end
