#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>

@interface POCWindowSceneDelegate : NSObject<UIWindowSceneDelegate>
@property (nonatomic, strong) UIWindow * window;
@end
@implementation POCWindowSceneDelegate
- (void) scene:(UIScene *) scene willConnectToSession:(UISceneSession *) session options:(UISceneConnectionOptions *) connectionOptions
{
  UIWindowScene * windowScene = (UIWindowScene *)scene;

  UIViewController * vc = [UIViewController new];
  vc.view = [UIView new];
  vc.view.backgroundColor = [UIColor redColor];

  UIWindow * w = [[UIWindow alloc] initWithWindowScene:windowScene];
  w.rootViewController = vc;

  self.window = w;
  [self.window makeKeyAndVisible];
}
@end

@interface POCAppDelegate : NSObject<UIApplicationDelegate>
@end
@implementation POCAppDelegate
- (UISceneConfiguration *) application:(UIApplication *) application 
configurationForConnectingSceneSession:(UISceneSession *) connectingSceneSession 
                               options:(UISceneConnectionOptions *) options
{
  // Kinda the only way after iOS 26

  UISceneConfiguration * res = [[UISceneConfiguration alloc] initWithName:@"poc"
                                                              sessionRole:connectingSceneSession.role];
  res.sceneClass = [UIWindowScene class];
  res.delegateClass = [POCWindowSceneDelegate class];
  return res;
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

