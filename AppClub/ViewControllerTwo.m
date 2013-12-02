//
//  ViewControllerTwo.m
//  AppClub
//
//  Created by Isaac Parker on 10/6/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import "ViewControllerTwo.h"
#import "EventCell.h"
#import "EventDetailView.h"

@interface ViewControllerTwo ()

@end

@implementation ViewControllerTwo

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshControl];
    [self fetchEvents];
}

- (IBAction)refreshTriggered:(id)sender {
    [self fetchEvents];
    [sender endRefreshing];
}

- (void)fetchEvents {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL: [NSURL URLWithString:@"http://django.sianware.com/app/json/easy_events/"]];
        if (data == nil) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection"
                                                                message:@"You must be connected to the internet to use this app."
                                                               delegate:nil
                                                      cancelButtonTitle:@"Bummer"
                                                      otherButtonTitles:nil];
                [alert show];
            });
        } else {
            NSError* error;
            NSArray* incomingEvents = [NSJSONSerialization
                                     JSONObjectWithData:data
                                     options:kNilOptions
                                     error:&error];
            refreshDataIdentical = [events isEqualToArray:incomingEvents];
            if (!refreshDataIdentical) {
                events = incomingEvents;
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Reloading table data");
                    [self.tableView reloadData];
                    
                });
            }
        }
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection: (NSInteger)section
{
    return events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EventCell";
    EventCell *eventCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ((eventCell == nil) || (![eventCell isKindOfClass: EventCell.class])) { // I think this is needed due to the way iOS will recycle cells...but I'm not sure
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventCell" owner:self options:nil];
        eventCell = [nib objectAtIndex:0];
    }
    
    NSDictionary *event = [events objectAtIndex:indexPath.row];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageUrl = [[event objectForKey:@"fields"] objectForKey:@"location_icon"];
        NSString *fullUrl = [NSString stringWithFormat:@"http://django.sianware.com%@", imageUrl];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fullUrl]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            eventCell.eventIcon.image = [UIImage imageWithData:data];
        });
    });
    eventCell.eventTitle.text = [[event objectForKey:@"fields"] objectForKey:@"event_title"];
    eventCell.eventSubtitle.text = [[event objectForKey:@"fields"] objectForKey:@"event_subtitle"];
    eventCell.eventLocationName.text = [[event objectForKey:@"fields"] objectForKey:@"location"];
    eventCell.eventDateInfo.text = [[event objectForKey:@"fields"] objectForKey:@"date"];
    return eventCell;
}


// # # # # # # # # # # # # # # # # # # # # # # # #I don't understand why the commented block works in the Annoucements view controller, but not in this one...
- (void)tableView:(UITableView *)tbView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showEventDetail" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEventDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = events[indexPath.row];
        [[segue destinationViewController] setEventDetailItem:object];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
