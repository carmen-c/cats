//
//  ViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "ViewController.h"
#import "PictureCollectionViewCell.h"
#import "DownloadManager.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *photos;
@property (nonatomic) DownloadManager *downloadManager;
@end

@implementation ViewController

static NSString *const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.downloadManager = [[DownloadManager alloc]init];
    [self getPhotos];
   
}

#pragma mark - collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PictureCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.photo = self.photos[indexPath.row];
    return cell;

}

#pragma mark - general

-(void)getPhotos{
    [self.downloadManager getCatPhotos:^(NSArray *pictures) {
        self.photos = pictures;
        [self.collectionView reloadData];
    }];
}


@end
