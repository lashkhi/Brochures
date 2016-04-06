//
//  BrochuresCollectionViewController.m
//  Brochures
//
//  Created by David Lashkhi on 02/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "BrochuresCollectionViewController.h"
#import "BrochuresNetworkDataManager.h"
#import "ImageDownloaderService.h"
#import "Brochure.h"
#import "Sector.h"
#import "BrochuresCollectionViewCell.h"
#import "BrochuresHeaderCollectionReusableView.h"


@interface BrochuresCollectionViewController ()

@property (nonatomic, strong) NSArray *sectors;
@property (nonatomic, strong) NSCache *cache;

@end

@implementation BrochuresCollectionViewController

static NSString * const reuseIdentifier = @"BrochuresCollectionViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cache = [NSCache new];
        
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[BrochuresNetworkDataManager sharedInstance] fetchSectoresWithSuccess:^(NSArray *sectors) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.sectors = sectors;
                [self.collectionView reloadData];
            });
        } failure:^(NSError *error) {
            //show some error
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectors.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    Sector *sector = [self.sectors objectAtIndex:section];
    return sector.brochures.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BrochuresCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    Sector *sector = self.sectors[indexPath.section];
    Brochure *brochure = sector.brochures[indexPath.row];
    cell.titleLabel.text = brochure.brochureTitle;
    cell.retailerNameLabel.text = brochure.brochureRetailerName;
    
    NSString *keyString = [NSString stringWithFormat:@"brochure-%ld-%ld",(long)indexPath.section, (long)indexPath.row];
    if ([self.cache objectForKey:keyString]) {
        cell.brochureImageView.image = [self.cache objectForKey:keyString];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[ImageDownloaderService sharedInstance] fetchImageFromUrl:brochure.brochureCoverURL onDidLoad:^(UIImage *image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UICollectionViewCell *updateCell = [collectionView cellForItemAtIndexPath:indexPath];
                    if (updateCell && image) { //image checking was added as temp bug fixing
                        ((BrochuresCollectionViewCell *)updateCell).brochureImageView.image = image;
                        [self.cache setObject:image forKey:keyString];
                    }
                });
            }];
        });
    }
    
    return cell;
}


#pragma mark -  Header

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView;
    if (kind == UICollectionElementKindSectionHeader) {
        BrochuresHeaderCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BrochuresHeaderCollectionReusableView" forIndexPath:indexPath];
        Sector *sector = self.sectors[indexPath.section];
        headerView.headerLabel.text = sector.sectorName;
        headerView.numberOfBrochuresLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)sector.brochures.count];
        NSString *keyString = [NSString stringWithFormat:@"sector%ld",(long)indexPath.section];
        if ([self.cache objectForKey:keyString]) {
            headerView.sectorImage.image = [self.cache objectForKey:keyString];
        } else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[ImageDownloaderService sharedInstance] fetchImageFromUrl:sector.sectorURL onDidLoad:^(UIImage *image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UICollectionReusableView *updateHeaderView = [collectionView supplementaryViewForElementKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
                        if (updateHeaderView && image) {
                            ((BrochuresHeaderCollectionReusableView *)updateHeaderView).sectorImage.image = image;
                            [self.cache setObject:image forKey:keyString];
                        }
                    });
                }];
            });
        }
                reusableView = headerView;
    }
    return reusableView;
}


@end
