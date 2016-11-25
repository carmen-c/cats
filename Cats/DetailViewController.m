//
//  DetailViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-22.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "DetailViewController.h"
#import "LocationManager.h"
#import <MapKit/MapKit.h>



@interface DetailViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *catMapView;
@property (nonatomic) LocationManager *locationManager;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[LocationManager alloc]init];
    [self.locationManager getLocation:self.chosenPhoto completion:^(CLLocationCoordinate2D coordinate) {
        self.chosenPhoto.coordinate = coordinate;
        [self annotationDisplay];
    }];
}

#pragma mark - Setup 

-(void)annotationDisplay{
   
    //MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    //annotation.coordinate = self.chosenPhoto.coordinate;

    MKCoordinateSpan span = MKCoordinateSpanMake(0.5f, 0.5f);
    self.catMapView.region = MKCoordinateRegionMake(self.chosenPhoto.coordinate, span);
    [self.catMapView addAnnotation:self.chosenPhoto];
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ParkingPin"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.chosenPhoto.imageUrl];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:imageData]];
    imageView.frame = CGRectMake(0, 0, 50, 50);
    
    annView.animatesDrop = TRUE;
    annView.canShowCallout = YES;
    annView.calloutOffset = CGPointMake(-5, 5);
    [annView addSubview:imageView];
    return annView;
}







@end
