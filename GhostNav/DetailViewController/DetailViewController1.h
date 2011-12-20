//
//  DetailViewController1.h
//  GhostNav
//
//  Created by DGM59 on 11/17/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "WebView.h"
#import <AVFoundation/AVFoundation.h>
#import "SoundManager.h"

@interface DetailViewController1 : UIViewController <NSURLConnectionDataDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    
    NSDictionary *aStory;
    NSMutableData *receivedData;
    NSString *webString;
    SoundManager *player;
}

@property (nonatomic, retain) NSDictionary *aStory;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSString *webString;
@property (nonatomic, retain) SoundManager *player;

- (void)pushView: (id)sender;
@end
