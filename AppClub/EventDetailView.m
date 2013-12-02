//
//  EventDetailView.m
//  AppClub
//
//  Created by Isaac Parker on 10/24/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import "EventDetailView.h"

@interface EventDetailView ()
@property (weak, nonatomic) IBOutlet UIImageView *detailEventIcon;
@property (weak, nonatomic) IBOutlet UILabel *detailEventTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailEventLocation;
@property (weak, nonatomic) IBOutlet UITextView *detailEventSummary;
@property (strong, nonatomic) UIImage *eventIcon;

@end

@implementation EventDetailView

@synthesize detailEventIcon;
@synthesize detailEventTitle;
@synthesize detailEventLocation;
@synthesize detailEventSummary;
@synthesize eventDetailItem;
@synthesize eventIcon;

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
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [NSString stringWithFormat:@"http://django.sianware.com%@", [[eventDetailItem objectForKey:@"fields"] objectForKey:@"location_icon"]];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        dispatch_async(dispatch_get_main_queue(), ^{
            detailEventIcon.image = [UIImage imageWithData:data];
        });
    });
    detailEventTitle.text = [[eventDetailItem objectForKey:@"fields"] objectForKey:@"event_title"];
    detailEventSummary.text = [[eventDetailItem objectForKey:@"fields"] objectForKey:@"event_subtitle"];
    detailEventLocation.text = [[eventDetailItem objectForKey:@"fields"] objectForKey:@"location"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
