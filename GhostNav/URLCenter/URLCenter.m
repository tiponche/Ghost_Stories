//
//  URLCenter.m
//  GhostNav
//
//  Created by DGM59 on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "URLCenter.h"
#import "JSONKit.h"
#define hostURLString @"http://ohho.in.th:16000"

@implementation URLCenter
@synthesize delegate;

- (void)dealloc {
    self.delegate = nil;
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

+ (NSString *)hostURL
{
    return hostURLString;
}
@end
