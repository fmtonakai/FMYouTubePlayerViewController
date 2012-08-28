//
//  FMYouTubeSourceDetector.m
//  FMYouTubePlayerViewController
//
//  Created by fm.tonakai on 2012/08/27.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import "FMYouTubeVideoSourceDetector.h"
#import <UIKit/UIKit.h>

static NSString *embedYoutubeFormat =
@"<div id='ytplayer'></div>"
"<script>"
"var tag = document.createElement('script');"
"tag.src = 'https://www.youtube.com/player_api';"
"var firstScriptTag = document.getElementsByTagName('script')[0];"
"firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);"
"var player;"
"var didPlayed;"
"function onPlayerReady(event) {"
"    player.playVideo();"
"}"
"function onPlayerStateChange (event) {"
"    var e = player.getIframe().contentWindow.document.getElementsByTagName('video')[0];"
"    if (e) {"
"        setTimeout(function(){location.href = 'detect:///'}, 1000);"
"    }"
"}"
"function onYouTubePlayerAPIReady() {"
"    player = new YT.Player('ytplayer', {"
"    height: '500',"
"    width: '500',"
"    videoId: '%@',"
"    events: {"
"        'onReady': onPlayerReady,"
"        'onStateChange': onPlayerStateChange"
"    }"
"    });"
"}"
"</script>";

@interface FMYouTubeVideoSourceDetector () <UIWebViewDelegate>

-(UIWebView *)webView;

@end

@implementation FMYouTubeVideoSourceDetector
{
    UIWebView *_webView;
    FMYouTubeViewSourceDetectorCompletionBlock _completion;
}

-(void)detectSourceURLofVideoId:(NSString *)videoId completion:(FMYouTubeViewSourceDetectorCompletionBlock)completion
{
    _completion = [completion copy];
    NSString *html = [NSString stringWithFormat:embedYoutubeFormat, videoId];
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
}

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)];
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - UIWebViewDelegate


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme isEqualToString:@"detect"]) {
        NSString *detectJs = @"player.getIframe().contentWindow.document.getElementsByTagName('video')[0].src;";
        NSString *src = [webView stringByEvaluatingJavaScriptFromString:detectJs];
        NSURL *sourceURL;
        NSError *error;
        if (src.length != 0) {
            sourceURL = [NSURL URLWithString:src];
        } else {
            error = [NSError errorWithDomain:NSNetServicesErrorDomain
                                                 code:NSNetServicesNotFoundError
                                             userInfo:nil];
        }
        if (_completion) {
            _completion(sourceURL, error);
        }
        return NO;
    }
    return YES;
}
@end
