//
//  URLCenter.h
//  GhostNav
//
//  Created by DGM59 on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLCenterDelegate <NSObject>

+ (NSString *)hostURL;

@end

@interface URLCenter : NSObject{
    id<URLCenterDelegate> delegate;
}

@property (nonatomic, assign) id<URLCenterDelegate> delegate;

+ (NSString *)hostURL;

@end
