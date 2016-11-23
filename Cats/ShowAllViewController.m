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

@interface ShowAllViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *allMapView;
@end

@implementation ShowAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getGeoLocations];
}

#pragma mark - Setup

-(void)annotationDisplay:(Photo *)aPhoto{
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = aPhoto.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(1.0f, 1.0f);
    self.allMapView.region = MKCoordinateRegionMake(aPhoto.coordinate, span);
    [self.allMapView addAnnotation:annotation];
    
}

#pragma mark - Location

-(void)getGeoLocations {

    for (Photo *photo in self.allPhotos){

    NSURL *url = [self getGeoLocationUrl: photo];
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
            photo.coordinate = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
            [self annotationDisplay:photo];
        }];
        
    }];
    
    [dataTask resume];
    }
}


-(NSURL *)getGeoLocationUrl:(Photo *)aPhoto{
    
    NSDictionary *queries = @{@"method": @"flickr.photos.geo.getLocation", @"api_key":@"9c767a008dc29a02317c67afc0206d96", @"format":@"json", @"nojsoncallback":@"1", @"photo_id":aPhoto.photoId};
    
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
