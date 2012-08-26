//
//  YouTubePlayerViewController.m
//  YouTubePlayer
//
//  Created by fm.tonakai on 2012/08/25.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import "FMYouTubePlayerViewController.h"

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


@interface FMYouTubePlayerViewController () <UIWebViewDelegate>
-(UIWebView *)webView;

@end

@implementation FMYouTubePlayerViewController
{
    NSString *_videoId;
    NSURL *_sourceURL;
    UIWebView *_webView;
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

-(UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)];
        _webView.delegate = self;
    }
    return _webView;
}

-(void)startDetectVideoSourceURL;
{
    NSString *html = [NSString stringWithFormat:embedYoutubeFormat, self.videoId];
    [self.webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.youtube.com"]];
}

-(void)playVideo
{
    self.moviePlayer.contentURL = _sourceURL;
    [self.moviePlayer play];
}

#pragma mark - UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.scheme isEqualToString:@"detect"]) {
        NSString *detectJs = @"player.getIframe().contentWindow.document.getElementsByTagName('video')[0].src;";
        NSString *src = [webView stringByEvaluatingJavaScriptFromString:detectJs];
        _sourceURL = [NSURL URLWithString:src];
        [self playVideo];
        return NO;
    }
    return YES;
}

@end
