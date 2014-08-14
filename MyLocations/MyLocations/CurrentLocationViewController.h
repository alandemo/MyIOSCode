//
//  FirstViewController.h
//  MyLocations
//
//  Created by yekaiyu on 14-8-14.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentLocationViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel* messageLabel;

@property (nonatomic,strong) IBOutlet UILabel* latitudeLabel;

@property (nonatomic,strong) IBOutlet UILabel* longitudelabel;

@property (nonatomic,strong) IBOutlet UILabel* addressLabel;

@property (nonatomic,strong) IBOutlet UIButton* tagButton;

@property (nonatomic,strong) IBOutlet UIButton* getButton;

@end

