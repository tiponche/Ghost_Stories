//
//  SoundManager.h
//  GhostNav
//
//  Created by DGM59 on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol SoundManagerDelegate <NSObject>

- (void)playAudio;
- (void)playSecondAudio;
- (void)stopAudio;

@end

@interface SoundManager : NSObject {
    id <SoundManagerDelegate>delegate;
    AVAudioPlayer *player;
}

@property (nonatomic, retain) id <SoundManagerDelegate>delegate;
@property (nonatomic, retain) AVAudioPlayer *player;

- (void)playAudio;
- (void)playSecondAudio;
- (void)stopAudio;

@end
