//
//  ShowAllViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-22.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "ShowAllViewController.h"
#import <MapKit/MapKit.h>
#import "Photo.h"
#import "LocationManager.h"

@interface ShowAllViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *allMapView;
@property (nonatomic) LocationManager *locationManager;
@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[LocationManager alloc]init];
    for (Photo *photo in self.allPhotos) {
        
    [self.locationManager getLocation:photo completion:^(CLLocationCoordinate2D coordinate) {
        photo.coordinate = coordinate;
        [self annotationDisplay];
        }];
    }
}

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.allPhotos = nil;
//}


#pragma mark - Setup

-(void)annotationDisplay{
    
    [self.allMapView addAnnotations:self.allPhotos];
}



@end
