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
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AstrostyleAppViewController *viewController;

@end

