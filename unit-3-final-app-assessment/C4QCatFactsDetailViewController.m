//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()

@property (nonatomic) NSString *catGIFURL;
@property (nonatomic) NSString *stillURL;

@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getCatImageFromAPIWithCallbackBlock:^{
        self.catImageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:self.catGIFURL]];
        self.catFactLabel.text = self.factToShow;
    }];
    
}

-(void)getCatImageFromAPIWithCallbackBlock:(void(^)())block{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *JSON = responseObject;
        NSArray *data = [JSON objectForKey:@"data"];
        
        NSUInteger randomIndex = arc4random_uniform(data.count - 10);
        NSDictionary *firstCat = [data objectAtIndex:randomIndex];
        
        NSDictionary *images = [firstCat objectForKey:@"images"];
        NSDictionary *fixedHeight = [images objectForKey:@"fixed_height"];
        NSString *url = [fixedHeight objectForKey:@"url"];
        self.catGIFURL = url;
        
        block();
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
