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
    CLLocation* location;
    BOOL updatingLocation;
    NSError* lastLocationError;
    CLGeocoder* geocoder;
    CLPlacemark* placemark;
    BOOL performingReverseGeocoder;
    NSError* lastGeocoderError;
    
}
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateLabels];
    [self configureGetButton];
    
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
        geocoder = [[CLGeocoder alloc]init];
    }
    
    return self;
    
}

- (IBAction)getLocation:(id)sender
{
    if (updatingLocation) {
        
        [self stopUpdatingLocation];
    }else{
        
        location = nil;
        lastLocationError = nil;
        
        placemark = nil;
        lastGeocoderError = nil;
        
        [self startUpdatingLocation];
        
    }

    [self updateLabels];
    [self configureGetButton];
    
}

- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailUpdateToLocation %@",error);
    
    if (error.code == kCLErrorLocationUnknown) {
        return;
    }
    
    [self stopUpdatingLocation];
    
    lastLocationError = error;
    
    [self updateLabels];
    [self configureGetButton];
}

-(void)stopUpdatingLocation
{
    
    if(updatingLocation){
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(didTimeOut:) object:nil];
        
        [locationManager stopUpdatingLocation];
        locationManager.delegate = nil;
        updatingLocation = NO;
    }
    
}

- (void)startUpdatingLocation
{
    
    if([CLLocationManager locationServicesEnabled]){
        
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locationManager startUpdatingLocation];
        updatingLocation = YES;
        
        [self performSelector:@selector(didTimeOut:) withObject:nil afterDelay:60];
        
    }
    
}

- (void) didTimeOut:(id)obj
{
    
    NSLog(@"******************** Time out!");
    
    if(location == nil){
        
        [self stopUpdatingLocation];
        
        lastLocationError = [NSError errorWithDomain:@"MyLocationsErrorDomain" code:1 userInfo:nil];
        
        [self updateLabels];
        [self configureGetButton];
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSLog(@"didUpdateTolocation %@" , [locations objectAtIndex:0]);
    
    CLLocation* newLocation = [locations objectAtIndex:0];
    
    if ([newLocation.timestamp timeIntervalSinceNow ] < -5) {
        return;
    }
    
    if (newLocation.horizontalAccuracy < 0) {
        return;
    }
    
    
    CLLocationDistance distance = MAXFLOAT;
    
    if (location!=nil) {
        distance = [newLocation distanceFromLocation:location];
    }
    
    if (location == nil || location.horizontalAccuracy > newLocation.horizontalAccuracy) {
        
        lastLocationError = nil;
        location = newLocation;
        [self updateLabels];
        
        if (newLocation.horizontalAccuracy <= locationManager.desiredAccuracy) {
            NSLog(@"************* We are done!");
            [self stopUpdatingLocation];
            [self configureGetButton];
            
            
            if(distance > 0){
                performingReverseGeocoder = NO;
            }
        }
        
        if (!performingReverseGeocoder) {
            NSLog(@"************ start reverse gecoder");
            
            performingReverseGeocoder = YES;
            
            [geocoder reverseGeocodeLocation:location completionHandler:
             ^(NSArray *placemarks, NSError *error) {
                 NSLog(@"Found placemarks %@  error %@",placemarks,error);
                 
                 lastGeocoderError = error;
                 
                 if (error == nil && [placemarks count] > 0) {
                     placemark = [placemarks lastObject];
                 }else{
                     placemark = nil;
                 }
                 
                 performingReverseGeocoder = NO;
                 [self updateLabels];
             }];
            
        
        }
    
 
    }else if (distance < 1.0) {
        
        NSTimeInterval timeInterval = [newLocation.timestamp timeIntervalSinceDate:location.timestamp];
        if (timeInterval > 10) {
            NSLog(@"*** Force done!");
            [self stopUpdatingLocation];
            [self updateLabels];
            [self configureGetButton];
        }

    }
    
}

- (void) updateLabels
{
    
    if(location != nil) {
        
        self.messageLabel.text = @"GPS Coordinate";
        self.latitudeLabel.text = [NSString stringWithFormat:@"%.8f",location.coordinate.latitude];
        self.longitudelabel.text = [NSString stringWithFormat:@"%.8f",location.coordinate.longitude];
        self.tagButton.hidden = NO;
        
        if (placemark != nil) {
            self.addressLabel.text = [self stringFromPlacemark:placemark];
        }else if (performingReverseGeocoder){
            self.addressLabel.text = @"searching address...";
        }else if (lastGeocoderError != nil){
            self.addressLabel.text = @"error finding address.";
        }else {
            self.addressLabel.text = @"no address found.";
        }
        
    }else{
        
        self.longitudelabel.text = @"";
        self.latitudeLabel.text = @"";
        self.addressLabel.text = @"";
        self.tagButton.hidden = YES;
        
        NSString* statusMessage;
        
        if(lastLocationError != nil ){
            
            if([lastLocationError.domain isEqualToString:kCLErrorDomain] && lastLocationError.code == kCLErrorDenied){
                
                statusMessage = @"location services disable";
            }else{
                statusMessage = @"error get Location";
            }
        }else if(![CLLocationManager locationServicesEnabled]){
            statusMessage = @"Location Services disable";
        }else if(updatingLocation){
            statusMessage = @"Searching...";
        }else{
            statusMessage = @"Press button to start..";
        }
        
        self.messageLabel.text = statusMessage;
        
    }
    
}

- (void)configureGetButton
{
    
    if(updatingLocation){
        [self.getButton setTitle:@"Stop" forState:UIControlStateNormal];
    }else{
        [self.getButton setTitle:@"Get My Location" forState:UIControlStateNormal];
    }
    
}

- (NSString *)stringFromPlacemark:(CLPlacemark *)thePlacemark
{
    
    
    return [NSString stringWithFormat:@"%@  %@\n%@  %@  %@",
            thePlacemark.subThoroughfare,thePlacemark.thoroughfare,
            thePlacemark.locality,thePlacemark.administrativeArea,
            thePlacemark.postalCode];
}

@end
