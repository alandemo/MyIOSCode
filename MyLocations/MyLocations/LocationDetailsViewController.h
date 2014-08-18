//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by Alan on 14-8-18.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationDetailsViewController : UITableViewController

@property (nonatomic,strong) IBOutlet UITextView* descriptionTextView;

@property (nonatomic,strong) IBOutlet UILabel* categoryLabel;

@property (nonatomic,strong) IBOutlet UILabel* latitudeLabel;

@property (nonatomic,strong) IBOutlet UILabel* longitudeLabel;

@property (nonatomic,strong) IBOutlet UILabel* addressLabel;

@property (nonatomic,strong) IBOutlet UILabel* dateLabel;

- (IBAction)done:(id)sender;

- (IBAction)cancel:(id)sender;

@end
