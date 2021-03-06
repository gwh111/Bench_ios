//
//  CC_VideoManager.m
//  bench_ios
//
//  Created by gwh on 2020/4/25.
//

#import "CC_VideoManager.h"
#import "ccs.h"

@interface CC_VideoManager ()

@property (nonatomic, retain) CC_Video *currentPlayingVideo;
@property (nonatomic, retain) NSMutableArray *playingURLs;//可以播放的列表，在屏幕看的到的播放器

@end

@implementation CC_VideoManager

+ (instancetype)shared {
    return [ccs registerSharedInstance:self block:^{
        
    }];
}

- (void)addVideo:(CC_Video *)video {
    if (!video) {
        return;
    }
    if (!_videos) {
        _videos = NSMutableSet.new;
    }
    if (_videos.count > 10) {
        [_videos removeAllObjects];
//        NSLog(@"_videosremoveAllObjects");
    }
    [_videos addObject:video];
}

- (void)removeVideo:(CC_Video *)video {
    if (!video) {
        return;
    }
    [_videos removeObject:video];
}

- (void)playVideoUrl:(NSString *)url {
    [self pauseAllVideos];
    for (CC_Video *video in _videos) {
        if (video.videoUrl) {
            if ([video.videoUrl.absoluteString is:url]) {
                _currentPlayingVideo = video;
                [video playMutely];
//                CCLOG(@"playing%@",url);
                break;
            }
        }
        
    }
}

- (void)addPlayVideoUrl:(NSString *)url {
    if (url.length <= 0) {
        return;
    }
    if (!_playingURLs) {
        _playingURLs = ccs.mutArray;
    }
    NSMutableArray *copyUrls = _playingURLs.mutableCopy;
    BOOL has = NO;
    for (int i = 0; i < copyUrls.count; i++) {
        NSString *tempUrl = copyUrls[i];
        if ([tempUrl is:url]) {
            has = YES;break;
        }
    }
    if (!has) {
        [copyUrls addObject:url];
        _playingURLs = copyUrls;
        [self findAndPlay];
    }
}

- (void)removePlayVideoUrl:(NSString *)url {
    NSMutableArray *copyUrls = _playingURLs.mutableCopy;
    BOOL has = NO;
    for (int i = 0; i < copyUrls.count; i++) {
        NSString *tempUrl = copyUrls[i];
        if ([tempUrl is:url]) {
            has = YES;
            [copyUrls removeObjectAtIndex:i];
            break;
        }
    }
    if (has) {
        _playingURLs = copyUrls;
        [self findAndPlay];
    }
}

- (void)pauseAllVideos {
    
    [_currentPlayingVideo pause];
    for (CC_Video *video in _videos) {
        [video pause];
    }
}

- (void)recoverPlayVideo {
    if (!_currentPlayingVideo) {
        return;
    }
    [_currentPlayingVideo playMutely];
    [self clean];
}

- (void)clean {
    
    [_playingURLs removeAllObjects];
}

- (void)findAndPlay {
    
    [self pauseAllVideos];
    if (_playingURLs.count <= 0) {
        return;
    }
    NSUInteger index = 0;
    if (_playingURLs.count > 0) {
        index = (_playingURLs.count - 1)/2;
    } else {
        index = (_playingURLs.count)/2;
    }
    NSString *url = _playingURLs[index];
    for (CC_Video *video in _videos) {
        if (video.videoUrl) {
            if ([video.videoUrl.absoluteString is:url]) {
                _currentPlayingVideo = video;
                [video playMutely];
//                CCLOG(@"playing%@",url);
                break;
            }
        }
        
    }
//    CCLOG(@"%@",_playingURLs);
}

@end
