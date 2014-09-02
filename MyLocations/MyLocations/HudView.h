//
//  HudView.h
//  MyLocations
//
//  Created by Alan on 14-9-2.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HudView : UIView

+ (HudView *)hudInView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic,strong) NSString *text;

@end
