//
//  DetailViewController.h
//  GhostNav
//
//  Created by DGM59 on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    NSDictionary *aStory;
    UITextView *detail;
}

@property (nonatomic, retain) NSDictionary *aStory;
@property (nonatomic, retain) UITextView *detail;

@end
