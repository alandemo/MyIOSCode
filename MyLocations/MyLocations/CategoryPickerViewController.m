//
//  CategoryPickerViewController.m
//  MyLocations
//
//  Created by Alan on 14-8-25.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import "CategoryPickerViewController.h"

@interface CategoryPickerViewController ()

@end

@implementation CategoryPickerViewController{
    NSArray* categories;
    NSIndexPath* selectedIndexPath;
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    categories = [NSArray arrayWithObjects:
                  @"No Category",
                  @"Apple Store",
                  @"Bar",
                  @"Bookstore",
                  @"Club",
                  @"Grocery Store",
                  @"Historic Building",
                  @"House",
                  @"Icecream Vendor",
                  @"Landmark",
                  @"Park",
                  nil];

}

#pragma  mark -  UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return categories.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellIdentifier=@"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    
    if(cell == nil ){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    NSString* categoryName = [categories objectAtIndex:indexPath.row];
    cell.textLabel.text = categoryName;
    
    if([categoryName isEqualToString:self.selectedCategoryName]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row != selectedIndexPath.row){
        
        UITableViewCell* newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell* oldCell = [tableView cellForRowAtIndexPath:selectedIndexPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        selectedIndexPath = indexPath;
        
    }
    
    NSString* categoryName = [categories objectAtIndex:indexPath.row];
    [self.delegate categoryPicker:self didPickCategory:categoryName];
    
}


@end
