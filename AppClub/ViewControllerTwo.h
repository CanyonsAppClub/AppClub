//
//  ViewControllerTwo.h
//  AppClub
//
//  Created by Isaac Parker on 10/6/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerTwo : UITableViewController {
    NSArray *events;
    bool refreshDataIdentical;
}

- (IBAction)refreshTriggered:(id)sender;
- (void)fetchEvents;

@end
