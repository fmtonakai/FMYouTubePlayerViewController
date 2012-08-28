//
//  YouTubePlayerViewController.m
//  YouTubePlayer
//
//  Created by fm.tonakai on 2012/08/25.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import "FMYouTubePlayerViewController.h"
#import "FMYouTubeVideoSourceDetector.h"

@interface FMYouTubePlayerViewController () <UIWebViewDelegate>
@end

@implementation FMYouTubePlayerViewController
{
    NSString *_videoId;
    NSURL *_sourceURL;
    FMYouTubeVideoSourceDetector *detector;
}

-(id)initWithVideoId:(NSString *)videoId
{
    self = [super init];
    if (self) {
        _videoId = videoId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self startDetectVideoSourceURL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)videoId
{
    return _videoId;
}

-(void)startDetectVideoSourceURL;
{
    detector = [[FMYouTubeVideoSourceDetector alloc] init];
    __weak FMYouTubePlayerViewController *_self = self;
    [detector detectSourceURLofVideoId:self.videoId
                            completion:^(NSURL *sourceURL, NSError *error) {
                                if (error) {
                                    [_self.presentingViewController dismissMoviePlayerViewControllerAnimated];
                                    return;
                                }
                                _self.moviePlayer.contentURL = sourceURL;
                            }];
}

@end
