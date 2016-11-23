//
//  ViewController.m
//  Cats
//
//  Created by carmen cheng on 2016-11-21.
//  Copyright © 2016 carmen cheng. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "ShowAllViewController.h"
#import "PictureCollectionViewCell.h"
#import "DownloadManager.h"
#import "SearchViewController.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSArray *photos;
@property (nonatomic) DownloadManager *downloadManager;
@property (nonatomic) NSIndexPath *selectedCell;
@end

@implementation ViewController

static NSString *const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.downloadManager = [[DownloadManager alloc]init];
    [self getPhotos];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(aNewTag:) name:@"newTags" object:nil];

}


//- (IBAction)switchTriggered:(id)sender {
//    if (self.switchButton.state == YES) {
//        
//    }
//}

-(void)aNewTag:(NSNotification *)notify{
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

#pragma mark - navigation

- (IBAction)showAllButton:(id)sender {
    [self performSegueWithIdentifier:@"showAll" sender:sender];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCell = indexPath;
    [self performSegueWithIdentifier:@"detailView" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"detailView"]) {
        Photo *selectedPhoto = [self.photos objectAtIndex:self.selectedCell.row];
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.chosenPhoto = selectedPhoto;
    }else if ([segue.identifier isEqualToString:@"showAll"]) {
        ShowAllViewController *showAllVC = segue.destinationViewController;
        showAllVC.allPhotos = [NSMutableArray arrayWithArray:self.photos];
    }
}

#pragma mark - general

-(void)getPhotos{
    [self.downloadManager getCatPhotos:^(NSArray *pictures) {
        self.photos = pictures;
        [self.collectionView reloadData];
    }];
}


@end
