//
//  HudView.m
//  MyLocations
//
//  Created by Alan on 14-9-2.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import "HudView.h"

@implementation HudView

+ (HudView *)hudInView:(UIView *)view animated:(BOOL)animated
{
    
    HudView* hudView = [[HudView alloc] initWithFrame:view.bounds];
    
    hudView.opaque = NO;
    
    [view addSubview:hudView];
    
    view.userInteractionEnabled = NO;
    
    hudView.backgroundColor = [UIColor colorWithRed:1.0f green:0 blue:0 alpha:0.5f];
    
    return hudView;
    
}

@end
