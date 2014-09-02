//
//  LocationDetailsViewController.m
//  MyLocations
//
//  Created by Alan on 14-8-18.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import "LocationDetailsViewController.h"
#import "CategoryPickerViewController.h"

@interface LocationDetailsViewController ()

@end

@implementation LocationDetailsViewController{
    NSString* descriptionText;
    NSString* categoryName;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if(self = [super initWithCoder:aDecoder]){
        descriptionText = @"";
        categoryName = @"No Category";
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.descriptionTextView.text = descriptionText;
    self.categoryLabel.text = categoryName;
    
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f",self.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.8f",self.coordinate.longitude];
    
    if(self.placemark != nil){
        
        self.addressLabel.text = [self stringFromPlacemark:self.placemark];
    }else{
        
        self.addressLabel.text = @"NO Address Found";
    }
    self.dateLabel.text = [self formatDate:[NSDate date]];
    
    UITapGestureRecognizer* gestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:gestureRecognizer];
}

-(void)hideKeyboard:(UITapGestureRecognizer *)gestureRecognizer
{
    
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    if(indexPath != nil && indexPath.section == 0 && indexPath.row == 0){
        return;
    }
    
    [self.descriptionTextView resignFirstResponder];
    
}

- (NSString*)stringFromPlacemark:(CLPlacemark*)thePlacemark
{
    
    return [NSString stringWithFormat:@"%@, %@, %@, %@, %@, %@",
            self.placemark.subThoroughfare,self.placemark.thoroughfare,
            self.placemark.locality,self.placemark.administrativeArea,
            self.placemark.postalCode,self.placemark.country];
    
}

- (NSString *)formatDate:(NSDate *)theDate
{
    
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }

    
    return [formatter stringFromDate:theDate];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//
//    // Return the number of rows in the section.
//    return 0;
//}

- (IBAction)done:(id)sender
{
//    NSLog(@"Description %@ ",descriptionText);
//    
//    [self closeScreen];
    
    
}

- (IBAction)cancel:(id)sender
{
    
    [self closeScreen];
    
}

- (void) closeScreen
{
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section == 0 && indexPath.row == 0){
        
        return 88;
        
    } else if (indexPath.section == 2 && indexPath.row == 2){
        
        CGRect rect = CGRectMake(100, 10, 190, 1000);
        self.addressLabel.frame = rect;
        [self.addressLabel sizeToFit];
        
        rect.size.height = self.addressLabel.frame.size.height;
        self.addressLabel.frame = rect;
        
        return  self.addressLabel.frame.size.height + 20;
        
    }else{
        
        return 44;
    }
    
}


#pragma mark -UITextViewDlegate

- (BOOL)textView:(UITextView *)theTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    descriptionText = [theTextView.text stringByReplacingCharactersInRange:range withString:text];
    return YES;
    
}

- (void)textViewDidEndEditing:(UITextView *) theTextView
{
    
    descriptionText = theTextView.text;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"PickCategory"]) {
        CategoryPickerViewController* controller = segue.destinationViewController;
        controller.delegate = self;
        controller.selectedCategoryName = categoryName;
    }
    
}

#pragma mark - CategoryPickerViewControllerDelegate

-(void)categoryPicker:(CategoryPickerViewController *)picker didPickCategory:(NSString *)theCategoryName
{
    
    categoryName = theCategoryName;
    self.categoryLabel.text = categoryName;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0|| indexPath.section == 1){
        return indexPath;
    }else{
        return nil;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section == 0 && indexPath.row == 0){
        
        [self.descriptionTextView becomeFirstResponder];
        
    }
    
}

@end
