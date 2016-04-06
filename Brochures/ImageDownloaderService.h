//
//  ImageDownloaderService.h
//  Brochures
//
//  Created by David Lashkhi on 03/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ImageDownloaderService : NSObject

typedef void (^ImageDidLoadBlock)(UIImage *image);

+ (instancetype)sharedInstance;

-(void)fetchImageFromUrl:(NSString*)urlString onDidLoad:(ImageDidLoadBlock)onImageDidLoad;

@end
