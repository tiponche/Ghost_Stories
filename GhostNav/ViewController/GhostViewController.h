//
//  GhostViewController.h
//  GhostNav
//
//  Created by DGM59 on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLCenter.h"
#import "DetailViewController1.h"
#import "MBProgressHUD.h"
#import <AVFoundation/AVFoundation.h>
#import "SoundManager.h"
#import "IOHostAudio.h"

@interface GhostViewController : UITableViewController <URLCenterDelegate, NSURLConnectionDataDelegate, MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    
    NSMutableArray *arrayFromData;
    NSDictionary *storyObjectDictionary;
    UIImage *imageThumb;
    URLCenter *urlCenter;
    NSInteger pageNumber;
    NSUInteger countAll;
    NSUInteger numberToDisplay;
    NSMutableData *receivedData;
    NSMutableArray *myNewArray;
    SoundManager *player;
    
    IOHostAudio *audioObject;
    
}

@property (nonatomic, retain) NSDictionary *storyObjectDictionary;
@property (nonatomic, retain) NSMutableArray *arrayFromData;
@property (nonatomic, retain) UIImage *imageThumb;
@property (nonatomic, retain) URLCenter *urlCenter;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, assign) NSUInteger countAll;
@property (nonatomic, assign) NSUInteger numberToDisplay;
@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSMutableArray *myNewArray;
@property (nonatomic, retain) SoundManager *player;

@property (nonatomic, retain) IOHostAudio *audioObject;

- (UIImage *)getImageThumb;
- (void)saveImage: (UIImage *)image: (NSString *)storyID;
- (UIImage *)loadImage: (NSString *)storyID;

+ (NSString *)hostURL;
- (void)getArrayFromLoadMore;
@end
