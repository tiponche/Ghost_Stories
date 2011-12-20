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
@synthesize delegate;

- (UIImage *)imageThumb: (int *)indexrow
{
    
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[URLCenter hostURL]] 
                                                cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    NSURLResponse *response;
	NSError *error = [[NSError alloc] init];
    NSData *rawData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&response error:&error];   
    NSData *arrayFromData = [rawData objectFromJSONData];
    
    NSDictionary *storyObjectDictionary = [arrayFromData objectFromJSONData];
    NSLog(@"%@", storyObjectDictionary);
    NSDictionary *story = [storyObjectDictionary objectForKey:@"story"];
    
    NSString *imageURL = [NSURL URLWithString:[story objectForKey:@"image_thumb"]];
    NSString *imagethumbString = [NSString stringWithFormat:@"%@%@", [URLCenter hostURL], imageURL];
    NSURL *imageThumbURL = [NSURL URLWithString:imagethumbString];
    NSData *imageData = [NSData dataWithContentsOfURL:imageThumbURL];
    UIImage *imageThumb = [UIImage imageWithData:imageData];
    
    return imageThumb;
}

@end
