//
//  FirstViewController.m
//  MyLocations
//
//  Created by yekaiyu on 14-8-14.
//  Copyright (c) 2014年 yekaiyu. All rights reserved.
//

#import "CurrentLocationViewController.h"

@interface CurrentLocationViewController ()

@end

@implementation CurrentLocationViewController{
    CLLocationManager* locationManager;
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self == [super initWithCoder:aDecoder]) {
        locationManager = [[CLLocationManager alloc]init];
    }
    
    return self;
    
}

- (IBAction)getLocation:(id)sender
{
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    
    
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailUpdateToLocation %@",error);
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSLog(@"didUpdateTolocation %@" , [locations objectAtIndex:0]);
    
}



@end
