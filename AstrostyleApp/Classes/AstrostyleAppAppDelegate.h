//
//  AstrostyleAppAppDelegate.h
//  AstrostyleApp
//
//  Created by SIPL MacMini on 25/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AstrostyleAppViewController;

@interface AstrostyleAppAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
    AstrostyleAppViewController *viewController;
	NSString *mon;
	NSString *dayValue;
	NSMutableDictionary *plistDictionary;
	UITabBarController *tabBarController;
}
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) NSString *mon;
@property (nonatomic, retain) NSString *dayValue;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AstrostyleAppViewController *viewController;
@property (nonatomic,retain)NSMutableDictionary *plistDictionary;

//+(NSString *) getValue:(NSString *)key;

@end

