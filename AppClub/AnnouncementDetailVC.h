//
//  AnnouncementDetailVC.h
//  AppClub
//
//  Created by Isaac Parker on 10/24/13.
//  Copyright (c) 2013 Sianware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementDetailVC : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *postInfo;

@end
