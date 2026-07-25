#import <CoreFoundation/CoreFoundation.h>
#import <UIKit/UIKit.h>

#ifdef ADS
#  import <GoogleMobileAds/GoogleMobileAds.h>
#endif

#ifdef ADS
@interface POCWindowSceneDelegate : NSObject<UIWindowSceneDelegate, GADBannerViewDelegate>
@property (nonatomic, strong) GADBannerView * bannerView;
#else
@interface POCWindowSceneDelegate : NSObject<UIWindowSceneDelegate>
#endif
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

#ifdef ADS
  [GADMobileAds.sharedInstance startWithCompletionHandler:^(GADInitializationStatus * s) {
    GADBannerView *bannerView = [[GADBannerView alloc] init];
    bannerView.delegate = self;
    
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [vc.view addSubview:bannerView];
    
    // This example doesn't give width or height constraints, as the ad size gives the banner an
    // intrinsic content size to size the view.
    [NSLayoutConstraint activateConstraints:@[
      // Align the banner's bottom edge with the safe area's bottom edge
      [bannerView.bottomAnchor constraintEqualToAnchor:vc.view.safeAreaLayoutGuide.bottomAnchor],
      // Center the banner horizontally in the view
      [bannerView.centerXAnchor constraintEqualToAnchor:vc.view.centerXAnchor],
    ]];
    
    self.bannerView = bannerView;
  }];
#endif

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

