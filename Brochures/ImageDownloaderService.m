//
//  ImageDownloaderService.m
//  Brochures
//
//  Created by David Lashkhi on 03/04/16.
//  Copyright © 2016 David Lashkhi. All rights reserved.
//

#import "ImageDownloaderService.h"

@interface ImageDownloaderService ()

@end

@implementation ImageDownloaderService

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    static ImageDownloaderService *service;
    dispatch_once(&onceToken,
                  ^{
                      service = [ImageDownloaderService new];
                  });
    return service;
    
}

-(void)fetchImageFromUrl:(NSString*)urlString onDidLoad:(ImageDidLoadBlock)onImageDidLoad {
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:URL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:imageData];
        onImageDidLoad(image);
    }];
    [task resume];
}


@end
