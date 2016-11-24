//
//  LocationManager.m
//  Cats
//
//  Created by carmen cheng on 2016-11-23.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

-(void)getLocation:(Photo *)photo completion:(void (^)(CLLocationCoordinate2D))completion; {
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?nojsoncallback=1&photo_id=%@&method=flickr.photos.geo.getLocation&api_key=9c767a008dc29a02317c67afc0206d96&format=json", photo.photoId];
    
     NSURL *url = [NSURL URLWithString:urlString];
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
         
         double latitudeDouble = [latitude doubleValue];
         double logitudeDouble = [longitude doubleValue];
         CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitudeDouble, logitudeDouble);
         
         [[NSOperationQueue mainQueue]addOperationWithBlock:^{
             completion(coordinate);
         }];
         
     }];
     
     [dataTask resume];
 }

//-(NSURL *)getGeoLocationUrl:(Photo *)chosenPhoto{
//    
//    NSDictionary *queries = @{@"method": @"flickr.photos.geo.getLocation", @"api_key":@"9c767a008dc29a02317c67afc0206d96", @"format":@"json", @"nojsoncallback":@"1", @"photo_id":chosenPhoto.photoId};
//    
//    NSMutableArray *queryItems = [NSMutableArray array];
//    for (NSString *key in queries.allKeys) {
//        [queryItems addObject:[NSURLQueryItem queryItemWithName:key value:queries[key]]];
//    }
//    
//    NSURLComponents *components = [[NSURLComponents alloc]init];
//    components.scheme = @"https";
//    components.host = @"api.flickr.com";
//    components.path = @"/services/rest/";
//    components.queryItems = queryItems;
//    NSLog(@"%@", components.URL);
//    return components.URL;
//}

@end
