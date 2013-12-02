//
//  FirstViewController.m
//  AppClub
//
//  Created by Isaac Parker on 10/6/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import "FirstViewController.h"
#import "AnnouncementDetailVC.h"
//#import "AnnouncementCell.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = self.title;
    [self refreshControl];
    [self fetchAnnouncements];
}

- (IBAction)refreshTriggered:(id)sender {
    [self fetchAnnouncements];
    [sender endRefreshing];
}

- (void)fetchAnnouncements
{
    NSLog(@"Can reach Google: %s", [self canReachGoogle] ? "Cake" : "No Cake");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL:
                        [NSURL URLWithString: @"http://django.sianware.com/app/json/announcements/"]];
        if (data == nil) {
            NSLog(@"canReachGoogle: %s", [self canReachGoogle] ? "Sucess" : "FAIL");
            if([self canReachGoogle]) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Club Unreachable"
                                                                    message:@"The Canyons App Club servers are not reachable. This could be due to maintanance, or something unexpected has happended."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Okay"
                                                          otherButtonTitles:nil];
                    [alert show];
                });
            } else {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                                    message:@"You must be connected to the internet to use this app."
                                                                   delegate:nil
                                                          cancelButtonTitle:@"Okay, I'll get interwebz"
                                                          otherButtonTitles:nil];
                    [alert show];
                });
            }
        } else {
            NSError* error;
            NSArray *incomingAnnouncements = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            refreshDataIdentical = [incomingAnnouncements isEqualToArray:announcements];
            // # # # # # Good ol' fashion logging
            if(refreshDataIdentical) {
                NSLog(@"Refresh data is identical to previously loaded data...");
            } else {
                NSLog(@"OMG NEW DATAZ");
            }
            // # # # # #
            
            if(!refreshDataIdentical) {
                announcements = incomingAnnouncements;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Reloading Table data");
                    [self.tableView reloadData];
                });
            }
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"Announcements.count: %lu", (unsigned long)announcements.count);
    return announcements.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AnnouncementCell";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSDictionary *announcement = [announcements objectAtIndex:indexPath.row];
    cell.textLabel.text = [[announcement objectForKey:@"fields"] objectForKey:@"title"];
    cell.detailTextLabel.text = [[announcement objectForKey:@"fields"] objectForKey:@"content"];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAnnouncementDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = announcements[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

- (bool) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int code = (int)[httpResponse statusCode];
    if (code == 200) {
        NSLog(@"We can hit Google! -- Success!!");
        return true;
    } else {
        NSLog(@"We're failing to reach Google...");
        return false;
    }
}

- (bool) canReachGoogle {
    NSString *serverAddress = @"http://google.com/blank.html";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverAddress]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:1];
    
    [request setHTTPMethod: @"GET"];
//    NSError *requestError;
//    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    NSURLResponse *urlResponse = nil;
//    if([NSURLConnection canHandleRequest:request]) {
    NSLog(@"%d", [self connection:urlConnection didReceiveResponse:urlResponse]);
    return [self connection:urlConnection didReceiveResponse:urlResponse];
//    } else {
//        return NO;
//    }
}

// # # # # # # # # # # # # # # # # # #
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}
// # # # # # # # # # # # # # # # # # #

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
