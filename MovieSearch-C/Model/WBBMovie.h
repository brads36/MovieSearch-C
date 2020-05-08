//
//  WBBMovie.h
//  MovieSearch-C
//
//  Created by Bryce Bradshaw on 5/8/20.
//  Copyright © 2020 Bryce Bradshaw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBBMovie : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSDecimalNumber *rating;
@property (nonatomic, readonly, copy) NSString *overview;
@property (nonatomic, readonly, copy) NSString *imagePath;

- (instancetype)initWithTitle:(NSString *)title
                       rating:(NSDecimalNumber *)rating
                     overview:(NSString *)overview
                    imagePath:(NSString *)imagePath;

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)resultsDictionary;

@end
