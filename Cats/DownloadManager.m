//
//  DownloadManager.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "DownloadManager.h"
#import "Photo.h"

@implementation DownloadManager

-(void)getCatPhotos:(void (^)(NSArray *))completion{
    
    NSURL *url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=9c767a008dc29a02317c67afc0206d96&tags=cat"];
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
        
        //        NSArray * photos = [[json valueForKey:@"photos"] valueForKey:@"photo"]; is exactly the same as the line below
        NSArray * photos = json[@"photos"][@"photo"];
        
        NSArray *arrayOfPhotos = [Photo picturesWithArray:photos];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(arrayOfPhotos);
        }];
        
    }];
    
    [dataTask resume];
}


-(void)getImage:(NSURL *)url completion:(void (^)(UIImage *))completion{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        if(error) {
            NSLog(@"error: %@", error.localizedDescription);
            return ;
        }
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            completion(image);
        }];
    }];
    [downloadTask resume];
}

@end
