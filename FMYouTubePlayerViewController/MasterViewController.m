//
//  MasterViewController.m
//  FMYouTubePlayerViewController
//
//  Created by fm.tonakai on 2012/08/26.
//  Copyright (c) 2012年 fm.tonakai. All rights reserved.
//

#import "MasterViewController.h"
#import "FMYouTubePlayerViewController.h"

@interface MasterViewController () {
    NSArray *list;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (!list) {
        NSURL *url = [NSURL URLWithString:@"http://gdata.youtube.com/feeds/api/videos?alt=json&author=AKB48"];
        [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url]
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *res, NSData *data, NSError *error) {
                                   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                                                       options:0
                                                                                         error:nil];
                                   list = [[dic objectForKey:@"feed"] objectForKey:@"entry"];
                                   [self.tableView reloadData];
                               }];
    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    NSDictionary *dic = [list objectAtIndex:indexPath.row];
    cell.textLabel.text = [[dic objectForKey:@"title"] objectForKey:@"$t"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *dic = [list objectAtIndex:indexPath.row];
    NSString *url = [[dic objectForKey:@"id"] objectForKey:@"$t"];
    NSString *videoId = [url componentsSeparatedByString:@"/"].lastObject;
    
    FMYouTubePlayerViewController *vc = [[FMYouTubePlayerViewController alloc] initWithVideoId:videoId];
    [self presentMoviePlayerViewControllerAnimated:vc];
}

@end
