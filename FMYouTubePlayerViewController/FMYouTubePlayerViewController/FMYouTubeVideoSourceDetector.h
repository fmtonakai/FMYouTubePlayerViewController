//
//  FMYouTubeSourceDetector.h
//  FMYouTubePlayerViewController
//
//  Created by fm.tonakai on 2012/08/27.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^FMYouTubeViewSourceDetectorCompletionBlock)(NSURL *sourceURL, NSError *error);

@interface FMYouTubeVideoSourceDetector : NSObject

-(void)detectSourceURLofVideoId:(NSString *)videoId completion:(FMYouTubeViewSourceDetectorCompletionBlock)completion;

@end
