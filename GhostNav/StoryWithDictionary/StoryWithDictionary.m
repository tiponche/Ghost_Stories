//
//  StoryWithDictionary.m
//  GhostNav
//
//  Created by DGM59 on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StoryWithDictionary.h"
#import "JSONKit.h"
#import "URLCenter.h"

@implementation StoryWithDictionary
@synthesize receivedData, dataArray;

- (void)dealloc {
    self.receivedData = nil;
    self.dataArray = nil;
    [super dealloc];
}

-(StoryWithDictionary*)story:(id *)story 
{
    URLCenter *url = [[[URLCenter alloc] init] autorelease];
    
    
    self.dataArray = [[self.receivedData objectFromJSONData] autorelease];
    
    for (NSDictionary *storyObject in self.dataArray) {
        NSDictionary *story = [storyObject objectForKey:@"story"];
        NSLog(@"%@", [story objectForKey:@"story_snippet"]);
    }
    return self;
}

@end
