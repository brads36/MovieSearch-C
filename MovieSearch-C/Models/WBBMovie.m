//
//  WBBMovie.m
//  MovieSearch-C
//
//  Created by Bryce Bradshaw on 5/8/20.
//  Copyright © 2020 Bryce Bradshaw. All rights reserved.
//

#import "WBBMovie.h"

static NSString * const kOverview = @"overview";
static NSString * const kTitle = @"title";
static NSString * const kRating = @"vote_average";
static NSString * const kImagePath = @"poster_path";

@implementation WBBMovie

- (instancetype)initWithTitle:(NSString *)title rating:(NSDecimalNumber *)rating overview:(NSString *)overview imagePath:(NSString *)imagePath
{
    self = [super init];
    if (self)
    {
        _title = title;
        _rating = rating;
        _overview = overview;
        _imagePath = imagePath;
    }
    
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)resultsDictionary
{
    NSString *title = resultsDictionary[kTitle];
    NSDecimalNumber * rating = resultsDictionary[kRating];
    NSString *overview = resultsDictionary[kOverview];
    NSString *imagePath = resultsDictionary[kImagePath];
    
    return [self initWithTitle:title rating:rating overview:overview imagePath:imagePath];
}
@end
