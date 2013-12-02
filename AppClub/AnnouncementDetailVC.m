//
//  AnnouncementDetailVC.m
//  AppClub
//
//  Created by Isaac Parker on 10/24/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import "AnnouncementDetailVC.h"

@interface AnnouncementDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *announcementTitle;
@property (weak, nonatomic) IBOutlet UITextView *announcementBody;

@end

@implementation AnnouncementDetailVC

@synthesize announcementTitle;
@synthesize announcementBody;
@synthesize postInfo;

@synthesize detailItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    announcementTitle.text = [[detailItem objectForKey:@"fields"] objectForKey:@"title"];
    announcementBody.text = [[detailItem objectForKey:@"fields"] objectForKey:@"content"];
    NSString *creationDate = [[detailItem objectForKey:@"fields"] objectForKey:@"creation_date"];
    NSString *postingUser = [[detailItem objectForKey:@"fields"] objectForKey:@"created_by"];
    NSString *baseString = @"Posted ";
    NSString *postDateTime = [baseString stringByAppendingFormat:
                         @"%@ by %@", creationDate, postingUser];
    postInfo.text = postDateTime;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
