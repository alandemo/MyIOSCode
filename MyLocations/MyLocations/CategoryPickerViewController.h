//
//  CategoryPickerViewController.h
//  MyLocations
//
//  Created by Alan on 14-8-25.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CategoryPickerViewController;

@protocol CategoryPickerViewControllerDelegate <NSObject>

- (void)categoryPicker:(CategoryPickerViewController *)picker didPickCategory:(NSString *)categoryName;

@end

@interface CategoryPickerViewController : UITableViewController

@property (nonatomic,weak) id<CategoryPickerViewControllerDelegate> delegate;

@property (nonatomic,strong) NSString* selectedCategoryName;

@end
