//
//  StoryWithDictionary.h
//  GhostNav
//
//  Created by DGM59 on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoryWithDictionary : NSObject
{
    NSMutableData *receivedData;
    NSMutableArray *dataArray;
}

@property (nonatomic, retain) NSMutableData *receivedData;
@property (nonatomic, retain) NSMutableArray *dataArray;

-(StoryWithDictionary*)story:(id *)story;

@end
