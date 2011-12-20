//IOHostAudio.h

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface IOHostAudio : NSObject <AVAudioSessionDelegate> {

	Float64						graphSampleRate;
	NSTimeInterval				ioBufferDuration;
	
	AUGraph						processingGraph;
	AudioUnit					ioUnit;
	AudioUnit					mixerUnit;
    AudioUnit                   reverbUnit;
}

@property (readwrite)			Float64			graphSampleRate;
@property (readwrite)			NSTimeInterval	ioBufferDuration;
@property						AudioUnit		ioUnit;
@property						AudioUnit		mixerUnit;
@property                       AudioUnit       reverbUnit;

- (void) setupAudioSession;
- (void) configureAndInitializeAudioProcessingGraph;
- (void) startAUGraph;
- (void) stopAUGraph;

- (void) printErrorMessage: (NSString *) errorString withStatus: (OSStatus) result;
- (void) printASBD: (AudioStreamBasicDescription) asbd;

@end
