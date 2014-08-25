//
//  LocationDetailsViewController.h
//  MyLocations
//
//  Created by Alan on 14-8-18.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CategoryPickerViewController.h"

@interface LocationDetailsViewController : UITableViewController <UITextViewDelegate,CategoryPickerViewControllerDelegate>

@property (nonatomic,strong) IBOutlet UITextView* descriptionTextView;

@property (nonatomic,strong) IBOutlet UILabel* categoryLabel;

@property (nonatomic,strong) IBOutlet UILabel* latitudeLabel;

@property (nonatomic,strong) IBOutlet UILabel* longitudeLabel;

@property (nonatomic,strong) IBOutlet UILabel* addressLabel;

@property (nonatomic,strong) IBOutlet UILabel* dateLabel;

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

@property (nonatomic,strong) CLPlacemark* placemark;



- (IBAction)done:(id)sender;

- (IBAction)cancel:(id)sender;

@end
