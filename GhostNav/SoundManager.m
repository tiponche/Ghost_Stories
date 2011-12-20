//
//  SoundManager.m
//  GhostNav
//
//  Created by DGM59 on 12/2/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SoundManager.h"

@implementation SoundManager
@synthesize delegate;
@synthesize player;

-(void)dealloc {
    self.player = nil;
    self.delegate = nil;
    [super dealloc];
}

- (void)playAudio {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"GhostTown" ofType:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    
    self.player.volume = 0.4f;
    [self.player prepareToPlay];
    [self.player setNumberOfLoops:INFINITY];
    [self.player play];
}

- (void)playSecondAudio {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Churched" ofType:@"mp3"];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:nil];
    NSString *chainPath = [[NSBundle mainBundle] pathForResource:@"chainSound" ofType:@"mp3"];
    AVAudioPlayer *chainSound = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:chainPath] error:nil];
    
    self.player.volume = 0.4f;
    [self.player prepareToPlay];
    [self.player setNumberOfLoops:INFINITY];
    [self.player play];    
    
    chainSound.volume = 0.4f;
    [chainSound playAtTime:27];
    [chainSound prepareToPlay];
    [chainSound setNumberOfLoops:2];
    [chainSound play];
}

- (void)stopAudio {
    [self.player stop];
}

@end
