//
//  ViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "ViewController.h"
#import "PictureCollectionViewCell.h"
#import "Photo.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableArray *catPosts;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.catPosts = [[NSMutableArray alloc]init];
    
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
        
        for (NSDictionary *photo in photos) {
            NSString *pictureFarm = photo[@"farm"];
            NSString *pictureId = photo[@"id"];
            NSString *pictureServer = photo[@"server"];
            NSString *pictureSecret = photo[@"secret"];
            NSString *pictureTitle = photo[@"title"];
            
            NSString *pictureString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg", pictureFarm, pictureServer, pictureId, pictureSecret];
            NSURL *pictureUrl = [NSURL URLWithString:pictureString];
            
            Photo *catPost = [[Photo alloc]initWithTitle:pictureTitle andImageUrl:pictureUrl];
            [self.catPosts addObject:catPost];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.collectionView reloadData];
        }];
        
    }];
    
    [dataTask resume];
}


#pragma mark - collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.catPosts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    Photo *photos = self.catPosts[indexPath.row];
    NSData *data = [NSData dataWithContentsOfURL:photos.imageUrl];
    cell.pictureImageView.image = [UIImage imageWithData:data];
    cell.pictureTitleLabel.text = photos.title;
    
    return cell;

}

@end
