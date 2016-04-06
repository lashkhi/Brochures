//
//  BrochuresNetworkDataManager.h
//  Brochures
//
//  Created by David Lashkhi on 02/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class Sector;
@class Brochure;

@interface BrochuresNetworkDataManager : NSObject

typedef void (^NetworkDataManagerCompletionBlock)();


+ (instancetype)sharedInstance;

- (void)fetchSectoresWithSuccess:(void (^)(NSArray * sectors))success failure:(void (^)(NSError *error))failure;

@end
