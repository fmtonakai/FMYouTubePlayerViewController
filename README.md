YouTubeをアプリ内で再生するためのプレーヤー

## License
MIT License

## 使い方
プロジェクトの中のFMYouTubePlayerViewController.hをプロジェクト内にコピーしてください。
要:MediaPlayer framework

例)
http://www.youtube.com/watch?v=6uW-E496FXg
を再生する場合
```objective-c
    NSString *videoId = @"6uW-E496FXg";
    FMYouTubePlayerViewController *vc = [[FMYouTubePlayerViewController alloc] initWithVideoId:videoId];
    [self presentMoviePlayerViewControllerAnimated:vc];
```