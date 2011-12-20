//
//  StoryWithDictionary.h
//  GhostNav
//
//  Created by DGM59 on 11/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLCenter.h"
@class StoryWithDictionary;

@protocol StoryWithDictionaryDelegate <NSObject>

- (UIImage *)imageThumb: (int *)indexrow;

@end

@interface StoryWithDictionary : NSObject
{
    id <StoryWithDictionaryDelegate> delegate;
}

@property (nonatomic, retain) id <StoryWithDictionaryDelegate> delegate;
@end
