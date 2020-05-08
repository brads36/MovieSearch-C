//
//  WBBMovieController.m
//  MovieSearch-C
//
//  Created by Bryce Bradshaw on 5/8/20.
//  Copyright © 2020 Bryce Bradshaw. All rights reserved.
//

#import "WBBMovieController.h"

static NSString * const kBaseURL = @"https://api.themoviedb.org";
static NSString * const kImageBaseURL = @"http://image.tmdb.org/t/p/w500";
static NSString * const kMovieSearchPath = @"3/search/movie";
static NSString * const kApiKey = @"api_key";
static NSString * const kApiValue = @"31413ac43957974e65dbebd95b8aeaaf";
static NSString * const kQuery = @"query";
static NSString * const kResults = @"results";

@implementation WBBMovieController

// MARK: - Fetch Movies Function
+ (void)fetchMoviesForSearchTerm:(NSString *)searchTerm completion:(void (^)(NSArray<WBBMovie *> * _Nullable))completion
{
    // 1. prepare URL : http://api.themoviedb.org/3/search/movie?api_key=31413ac43957974e65dbebd95b8aeaaf&query=searchTerm
    NSURL *baseURL = [NSURL URLWithString:kBaseURL];
    NSURL *searchURL = [baseURL URLByAppendingPathComponent:kMovieSearchPath];
    
    NSURLComponents *URLComponents = [NSURLComponents componentsWithURL:searchURL resolvingAgainstBaseURL:true];
    NSURLQueryItem *apiQuery = [NSURLQueryItem queryItemWithName:kApiKey value:kApiValue];
    NSURLQueryItem *searchQuery = [NSURLQueryItem queryItemWithName:kQuery value:searchTerm];
    
    URLComponents.queryItems = @[apiQuery, searchQuery];
    
    NSURL *finalURL = URLComponents.URL;
    
    // 2. Start Data Task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        // 3. Handle Errors
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
           
        // 4. Check for Data
        if (!data)
        {
            NSLog(@"Error: No data returned from task.");
            completion(nil);
            return;
        }
           
        // 5. Decode Data from Json
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
        
        if (!jsonDictionary || ![jsonDictionary isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"Unable to create a dictionary from the data");
            completion(nil);
            return;
        }
        
        NSArray *resultsArray = jsonDictionary[kResults];
        NSMutableArray *movies = [NSMutableArray array];
        
        for (NSDictionary *movieDict in resultsArray) {
            
            WBBMovie *movie = [[WBBMovie alloc] initWithDictionary:movieDict];
            
            [movies addObject:movie];
        }
        
        completion(movies);
        
    }]resume];
}


// MARK: - Fetch Image Function
+ (void)fetchImageForImagePath:(NSString *)imagePath completion:(void (^)(UIImage * _Nullable))completion
{
    // 1. prep URL
    NSURL *baseURL = [NSURL URLWithString:kImageBaseURL];
    NSURL *finalURL = [baseURL URLByAppendingPathComponent:imagePath];
    
    // 2. Start Data Task
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    // 3. Handle Errors
    if (error)
    {
        NSLog(@"%@", error.localizedDescription);
        completion(nil);
        return;
    }
       
    // 4. Check for Data
    if (!data)
    {
        NSLog(@"Error: No data returned from task.");
        completion(nil);
        return;
    }
        UIImage *movieImage = [UIImage imageWithData:data];
        completion(movieImage);
        
    }]resume];
}

@end
