#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>

@interface POCAppDelegate : NSObject<UIApplicationDelegate>
@property(nonatomic, strong) UIWindow * window;
@end
@implementation POCAppDelegate
- (BOOL)application:(UIApplication *)app didFinishLaunchingWithOptions:(id)options {
  UIViewController * vc = [UIViewController new];
  vc.view = [UIView new];

  self.window = [UIWindow new];
  self.window.frame = [UIScreen mainScreen].bounds;
  self.window.rootViewController = vc;
  [self.window makeKeyAndVisible];
  return YES;
}
@end

// In theory, just a 'int main() {}' would already be installable on an iOS
// device, but it would not be useful for anything other than testing your
// deployment setup
int main(int argc, char ** argv) {
  @autoreleasepool {
    return UIApplicationMain(argc, argv, nil, @"POCAppDelegate");
  }
}

