//
//  BrochuresNetworkDataManager.m
//  Brochures
//
//  Created by David Lashkhi on 02/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "BrochuresNetworkDataManager.h"
#import "ImageDownloaderService.h"
#import "Sector.h"
#import "Brochure.h"


@implementation BrochuresNetworkDataManager

#warning TODO: Place your URL
static NSString * const urlString = @"https://www.putyouraddresshere.com/api.json";

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static BrochuresNetworkDataManager *manager;
    dispatch_once(&onceToken,
                  ^{
                      manager = [BrochuresNetworkDataManager new];
                  });
    return manager;
    
}


- (void)fetchSectoresWithSuccess:(void (^)(NSArray * sectors))success failure:(void (^)(NSError *error))failure {
    
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            NSArray *sectorsJson = jsonDictionary[@"sectors"];
            NSArray *sectors = [self createSectorsFromSectoresArray:sectorsJson];
            NSArray *sortedSectors = [sectors sortedArrayUsingComparator:^(Sector* a, Sector* b) {
                return [[a sectorName] compare:[b sectorName] options:NSCaseInsensitiveSearch];
            }];
            success (sortedSectors);
        } else if (error) {
            //handle error
        } else {
            //handle unknown error
        }

    }];
    [dataTask resume];
}

- (NSArray *)createSectorsFromSectoresArray:(NSArray *)sectorsJson {
    NSMutableArray *sectors = [NSMutableArray new];
    for (NSDictionary *sectorDictionary in sectorsJson) {
        Sector *sector = [Sector new];
        sector.sectorId = [sectorDictionary objectForKey:@"id"];
        sector.sectorURL = [sectorDictionary objectForKey:@"url"];
        sector.sectorName = [sectorDictionary objectForKey:@"name"];
        NSArray *brochuresArray = [self createBrochuresFromBrochuresArray:[sectorDictionary objectForKey:@"brochures"]];
        sector.brochures = brochuresArray;
        [sectors addObject:sector];
    }
    return sectors;
    
}

- (NSArray *)createBrochuresFromBrochuresArray:(NSArray *)brochuresArray {
    NSMutableArray *brochures = [NSMutableArray new];
    for (NSDictionary *brochuresDictionary in brochuresArray) {
        Brochure *brochure = [Brochure new];
        brochure.brochureId = [brochuresDictionary objectForKey:@"id"];
        brochure.brochureCoverURL = [brochuresDictionary objectForKey:@"coverUrl"];
        brochure.brochureTitle = [brochuresDictionary objectForKey:@"title"];
        brochure.brochureRetailerName = [brochuresDictionary objectForKey:@"retailerName"];
        [brochures addObject:brochure];
    }
    return brochures;
}

@end
