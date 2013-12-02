//
//  EventCell.h
//  AppClub
//
//  Created by Isaac Parker on 10/10/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *eventIcon;
@property (nonatomic, weak) IBOutlet UILabel *eventTitle;
@property (nonatomic, weak) IBOutlet UILabel *eventSubtitle;
@property (nonatomic, weak) IBOutlet UILabel *eventLocationName;
@property (weak, nonatomic) IBOutlet UILabel *eventDateInfo;

//@property (strong, nonatomic) id detailItem;

@end
