//
//  YouTubePlayerViewController.h
//  YouTubePlayer
//
//  Created by fm.tonakai on 2012/08/25.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface FMYouTubePlayerViewController : MPMoviePlayerViewController

-(id)initWithVideoId:(NSString *)videoId;

-(NSString *)videoId;
@end
