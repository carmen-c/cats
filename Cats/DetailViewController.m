//
//  DetailViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-22.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>



@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *catMapView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGeoLocation];
    
}

#pragma mark - Setup 

-(void)annotationDisplay{
   
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = _chosenPhoto.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(1.0f, 1.0f);
    self.catMapView.region = MKCoordinateRegionMake(self.chosenPhoto.coordinate, span);
    NSLog(@"%f", self.chosenPhoto.coordinate.longitude);
    [self.catMapView addAnnotation:annotation];
    
}

#pragma mark - Location

-(void)getGeoLocation {
    NSURL *url = [self getGeoLocationUrl:self.chosenPhoto];
    NSLog(@"%@", url);
    NSURLRequest *urlRequest = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error){
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"jsonError: %@", jsonError.localizedDescription);
            return;
        }
        
        NSDictionary *location = json[@"photo"][@"location"];
        NSNumber *latitude = [location valueForKey:@"latitude"];
        NSNumber *longitude = [location valueForKey:@"longitude"];
        
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.chosenPhoto.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
            [self annotationDisplay];
        }];
        
    }];
    
    [dataTask resume];
}


-(NSURL *)getGeoLocationUrl:(Photo *)chosenPhoto{
    
    NSDictionary *queries = @{@"method": @"flickr.photos.geo.getLocation", @"api_key":@"9c767a008dc29a02317c67afc0206d96", @"format":@"json", @"nojsoncallback":@"1", @"photo_id":self.chosenPhoto.photoId};
    
    NSMutableArray *queryItems = [NSMutableArray array];
    for (NSString *key in queries.allKeys) {
        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queries[key]]];
    }
    
    NSURLComponents *components = [[NSURLComponents alloc]init];
    components.scheme = @"https";
    components.host = @"api.flickr.com";
    components.path = @"/services/rest/";
    components.queryItems = queryItems;
    
    return components.URL;
}


@end
