//
//  WBBMovieController.h
//  MovieSearch-C
//
//  Created by Bryce Bradshaw on 5/8/20.
//  Copyright © 2020 Bryce Bradshaw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBBMovie.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBBMovieController : NSObject

+ (void)fetchMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^) (NSArray<WBBMovie *> * _Nullable))completion;

+ (void)fetchImageForImagePath:(NSString *)imagePath completion:(void (^) (UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
