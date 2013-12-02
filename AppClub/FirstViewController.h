//
//  FirstViewController.h
//  AppClub
//
//  Created by Isaac Parker on 10/6/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UITableViewController {
    NSArray *announcements;
    bool refreshDataIdentical;
}
- (IBAction)refreshTriggered:(id)sender;
- (void)fetchAnnouncements;

@end
