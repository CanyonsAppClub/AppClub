//
//  AnnouncementCell.m
//  AppClub
//
//  Created by Isaac Parker on 10/16/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import "AnnouncementCell.h"

@implementation AnnouncementCell

@synthesize title = _title;
@synthesize subtitle = _subtitle;

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
