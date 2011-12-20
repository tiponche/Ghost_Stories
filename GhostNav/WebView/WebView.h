//
//  WebView.h
//  GhostNav
//
//  Created by DGM59 on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface WebView : UIViewController <MBProgressHUDDelegate> {
    UIWebView *myWebView;
    NSString *webString;
}

@property (nonatomic, retain) UIWebView *myWebView;
@property (nonatomic, retain) NSString *webString;

@end
