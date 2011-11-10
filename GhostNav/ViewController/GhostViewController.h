//
//  GhostViewController.h
//  GhostNav
//
//  Created by DGM59 on 11/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLCenter.h"

@interface GhostViewController : UITableViewController
{
    NSArray *arrayFromData;
    NSDictionary *storyObjectDictionary;
}

@property (nonatomic, retain) NSDictionary *storyObjectDictionary;
@property (nonatomic, retain) NSArray *arrayFromData;

@end
