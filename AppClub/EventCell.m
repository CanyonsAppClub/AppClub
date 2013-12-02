//
//  EventCell.m
//  AppClub
//
//  Created by Isaac Parker on 10/10/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell

@synthesize eventIcon;
@synthesize eventTitle;
@synthesize eventSubtitle;
@synthesize eventLocationName;
@synthesize eventDateInfo;

//@synthesize detailItem = _detailItem;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
