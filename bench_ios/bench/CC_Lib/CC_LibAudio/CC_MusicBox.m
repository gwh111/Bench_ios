//
//  CC_MusicBox.m
//  bench_ios
//
//  Created by gwh on 2018/5/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CC_MusicBox.h"

@implementation CC_MusicBox

+ (instancetype)shared {
    return [CC_Base.shared cc_registerSharedInstance:self];
}

- (void)playSound:(NSString *)name type:(NSString *)type {
    if (_forbiddenSound) {
        return;
    }
    isMusic = 0;
    NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!strSoundFile) {
        CCLOG(@"strSoundFile=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:strSoundFile];
    _cc_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_cc_audioPlayer setDelegate:self];
    if (_defaultVolume>0) {
        _cc_audioPlayer.volume = _defaultVolume;
    }
    [_cc_audioPlayer prepareToPlay];
    [_cc_audioPlayer play];
}

- (void)stopMusic {
    [_cc_audioPlayer stop];
}

- (void)playMusic:(NSString *)name type:(NSString *)type {
    if (_forbiddenMusic) {
        return;
    }
    if (_cc_audioPlayer) {
        fadeTimeCount = 0;
        [self soundFadeOut:name type:type];
        return;
    }
    isMusic = 1;
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    if (!musicPath) {
        CCLOG(@"musicPath=nil");
        return;
    }
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    _cc_audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
    [_cc_audioPlayer setDelegate:self];
    if (_defaultVolume>0) {
        _cc_audioPlayer.volume = _defaultVolume;
    }
    if (_fadeIn) {
        fadeTimeCount = 0;
        _cc_audioPlayer.volume = 0.05;
        [self soundFadeIn];
    }
    [_cc_audioPlayer prepareToPlay];
    [_cc_audioPlayer play];
}

- (void)soundFadeOut:(NSString *)name type:(NSString *)type {
    if (fadeTimeCount < 10) {
        fadeTimeCount++;
        double delayInSeconds = 0.25;
        __block CC_MusicBox *blockSelf = self;
        [CC_CoreThread.shared delay:delayInSeconds block:^{
            blockSelf->_cc_audioPlayer.volume = 1 - blockSelf->fadeTimeCount*0.1;
            [self soundFadeOut:name type:type];
        }];
    }else{
        [_cc_audioPlayer stop];
        _cc_audioPlayer = nil;
        [self playMusic:name type:type];
    }
}

- (void)soundFadeIn {
    if (fadeTimeCount < 20) {
        fadeTimeCount++;
        double delayInSeconds = 0.25;
        __block CC_MusicBox *blockSelf = self;
        [CC_CoreThread.shared delay:delayInSeconds block:^{
            blockSelf->_cc_audioPlayer.volume = blockSelf->fadeTimeCount * 0.05;
            [self soundFadeIn];
        }];
    }
}

//播放完后
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag {
    if (isMusic) {
        if (_musicReplayTimes > 0) {
            _musicReplayTimes--;
            [_cc_audioPlayer play];
        }
    } else {
        if (_soundReplayTimes > 0) {
            _soundReplayTimes--;
            [_cc_audioPlayer play];
        }
    }
    
}

@end
